import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart' hide JsonKey;
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/data/database/app_database.dart' as db;
import 'package:overpass_map/data/repositories/map_repository.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
import 'package:overpass_map/features/map_explorer/domain/repositories/check_in_repository.dart';

part 'map_bloc.freezed.dart';
part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapRepository _mapRepository;
  final db.AppDatabase _database;
  final CheckInRepository _checkInRepository;
  StreamSubscription<String>? _areaStatsSubscription;
  String? _currentUserId;

  MapBloc({
    required MapRepository mapRepository,
    required db.AppDatabase database,
    required CheckInRepository checkInRepository,
  }) : _mapRepository = mapRepository,
       _database = database,
       _checkInRepository = checkInRepository,
       super(const MapState.initial()) {
    on<MapEvent>((event, emit) async {
      await event.when(
        fetchDataRequested: (cityName, adminLevel, userId) =>
            _onFetchDataRequested(emit, cityName, adminLevel, userId),
        areaSelected: (area) => _onAreaSelected(emit, area),
        spotSelected: (spot) => _onSpotSelected(emit, spot),
        refreshAreaDataRequested: (userId) =>
            _onRefreshAreaDataRequested(emit, userId),
      );
    });

    // Listen for area stats updates and auto-refresh
    _areaStatsSubscription = _checkInRepository.areaStatsUpdated.listen(
      (userId) {
        print(
          '🔔 MapBloc received area stats update notification for user $userId',
        );
        // Only refresh if this update is for the current user
        if (_currentUserId == userId) {
          add(MapEvent.refreshAreaDataRequested(userId: userId));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _areaStatsSubscription?.cancel();
    return super.close();
  }

  Future<void> _onFetchDataRequested(
    Emitter<MapState> emit,
    String cityName,
    int adminLevel,
    String? userId,
  ) async {
    emit(const MapState.loadInProgress());

    // Track current user ID for area stats updates
    _currentUserId = userId;

    try {
      final boundaryData = await _mapRepository.getCityBoundaryData(
        cityName: cityName,
        cityAdminLevel: adminLevel,
      );

      final allSpots = await _mapRepository.getSpots(cityName: cityName);

      // Filter spots to get exactly one per area (Stadtteil)
      final spotsToShow = _getOneSpotPerArea(
        areas: boundaryData.stadtteile,
        spots: allSpots,
      );

      // **NEW: Save spots to database for area stats calculations**
      await _saveSpotsToDatabaseWithAreas(spotsToShow, boundaryData.stadtteile);

      // Load user area data if user is authenticated
      final userAreaData = userId != null
          ? await _loadUserAreaData(userId)
          : <int, UserAreaData>{};

      print(
        '🎯 MapBloc emitting state with ${userAreaData.length} user area entries',
      );
      print('🎯 Areas in boundary data: ${boundaryData.stadtteile.length}');

      emit(
        MapState.loadSuccess(
          boundaryData: boundaryData,
          spots: spotsToShow,
          userVisitData: userAreaData,
          userSpotVisitData: {}, // Start with empty spot visit data
        ),
      );
    } catch (e) {
      emit(MapState.loadFailure(error: e.toString()));
    }
  }

  /// **NEW: Save spots to database with area associations**
  Future<void> _saveSpotsToDatabaseWithAreas(
    List<Spot> spots,
    List<GeographicArea> areas,
  ) async {
    try {
      for (final spot in spots) {
        // Find which area this spot belongs to
        int? parentAreaId;
        for (final area in areas) {
          for (final polygonRing in area.coordinates) {
            final polygonLatLng = polygonRing
                .map((coords) => LatLng(coords[1], coords[0]))
                .toList();
            if (_isPointInPolygon(spot.location, polygonLatLng)) {
              parentAreaId = area.id;
              break;
            }
          }
          if (parentAreaId != null) break;
        }

        // Skip spots that aren't in any area
        if (parentAreaId == null) continue;

        // Convert domain Spot to database Spot and save
        final dbSpot = db.SpotsCompanion.insert(
          id: Value(spot.id),
          name: spot.name,
          category: spot.category,
          lat: spot.location.latitude,
          lon: spot.location.longitude,
          parentAreaId: parentAreaId,
          spotType: spot.category,
          // Use category as spot type
          status: 'active',
          createdBy: Value(spot.createdBy),
          properties: Value(
            spot.properties.isNotEmpty ? spot.properties.toString() : null,
          ),
        );

        await _database.into(_database.spots).insertOnConflictUpdate(dbSpot);
      }

      print('💾 Saved ${spots.length} spots to database');
    } catch (e) {
      print('❌ Failed to save spots to database: $e');
    }
  }

  /// Loads user area completion data from the database
  Future<Map<int, UserAreaData>> _loadUserAreaData(String userId) async {
    try {
      final userAreas = await (_database.select(
        _database.userAreas,
      )..where((ua) => ua.userId.equals(userId))).get();

      final userAreaData = {
        for (final ua in userAreas)
          ua.areaId: UserAreaData(
            areaId: ua.areaId,
            totalSpots: ua.totalSpots,
            visitedSpots: ua.visitedSpots,
            completedAt: ua.completedAt,
          ),
      };

      print('🗺️ Loaded user area data for user $userId:');
      for (final entry in userAreaData.entries) {
        final data = entry.value;
        print(
          '  Area ${entry.key}: ${data.visitedSpots}/${data.totalSpots} spots (${data.status.name})',
        );
      }

      return userAreaData;
    } catch (e) {
      print('❌ Failed to load user area data: $e');
      return {};
    }
  }

  List<Spot> _getOneSpotPerArea({
    required List<GeographicArea> areas,
    required List<Spot> spots,
  }) {
    final spotsForAreas = <Spot>[];
    final assignedSpotIds = <int>{};

    for (final area in areas) {
      for (final spot in spots) {
        if (assignedSpotIds.contains(spot.id)) {
          continue; // This spot is already assigned to another area
        }

        bool isInside = false;
        for (final polygonRing in area.coordinates) {
          final polygonLatLng = polygonRing
              .map((coords) => LatLng(coords[1], coords[0]))
              .toList();
          if (_isPointInPolygon(spot.location, polygonLatLng)) {
            isInside = true;
            break;
          }
        }
        if (isInside) {
          spotsForAreas.add(spot);
          assignedSpotIds.add(spot.id);
          break; // Found a spot for this area, move to the next area
        }
      }
    }
    return spotsForAreas;
  }

  bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
    if (polygon.length < 3) {
      return false;
    }

    bool isInside = false;
    int j = polygon.length - 1;
    for (int i = 0; i < polygon.length; i++) {
      final p1 = polygon[i];
      final p2 = polygon[j];

      final isYBetween =
          (p1.latitude > point.latitude) != (p2.latitude > point.latitude);
      final isXBefore =
          point.longitude <
          (p2.longitude - p1.longitude) *
                  (point.latitude - p1.latitude) /
                  (p2.latitude - p1.latitude) +
              p1.longitude;

      if (isYBetween && isXBefore) {
        isInside = !isInside;
      }
      j = i;
    }

    return isInside;
  }

  Future<void> _onAreaSelected(
    Emitter<MapState> emit,
    GeographicArea? area,
  ) async {
    final currentState = state;
    if (currentState is _LoadSuccess) {
      emit(
        currentState.copyWith(
          selectedArea: area,
          selectedSpot: null, // Deselect spot when area is selected
        ),
      );
    }
  }

  Future<void> _onSpotSelected(Emitter<MapState> emit, Spot? spot) async {
    final currentState = state;
    if (currentState is _LoadSuccess) {
      emit(
        currentState.copyWith(
          selectedSpot: spot,
          selectedArea: null, // Deselect area when spot is selected
        ),
      );
    }
  }

  Future<void> _onRefreshAreaDataRequested(
    Emitter<MapState> emit,
    String userId,
  ) async {
    print('🔄 MapBloc: refreshAreaDataRequested called for user $userId');
    final currentState = state;
    if (currentState is! _LoadSuccess) {
      print('❌ MapBloc: Current state is not _LoadSuccess, skipping refresh');
      return;
    }

    try {
      // Reload user area data from database
      print('🔄 MapBloc: Loading user area data from database...');
      final updatedUserAreaData = await _loadUserAreaData(userId);

      // Emit updated state with new area data
      print(
        '🔄 MapBloc: Emitting updated state with ${updatedUserAreaData.length} areas',
      );
      emit(
        currentState.copyWith(
          userVisitData: updatedUserAreaData,
        ),
      );

      print(
        '🔄 Area data refreshed for user $userId: ${updatedUserAreaData.length} areas',
      );
    } catch (e) {
      print('❌ Failed to refresh area data: $e');
    }
  }
}
