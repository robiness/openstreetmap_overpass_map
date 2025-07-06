import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
        mapViewChanged: (bounds) => _onMapViewChanged(emit),
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
    print('🏙️ MapBloc: _onFetchDataRequested called for city: $cityName');
    emit(const MapState.loadInProgress());

    // Track current user ID for area stats updates
    _currentUserId = userId;

    try {
      print('🏙️ MapBloc: Loading boundary data...');
      final boundaryData = await _mapRepository.getCityBoundaryData(
        cityName: cityName,
        cityAdminLevel: adminLevel,
      );
      print('✅ MapBloc: Boundary data loaded successfully');

      print('🎯 MapBloc: Loading spots...');
      // Load all spots at startup
      final spots = await _mapRepository.getSpots();
      print('✅ MapBloc: Loaded ${spots.length} spots');

      print('👤 MapBloc: Loading user area data...');
      final userAreaData = userId != null
          ? await _loadUserAreaData(userId)
          : <String, UserAreaData>{};
      print(
        '✅ MapBloc: Loaded user area data for ${userAreaData.length} areas',
      );

      print(
        '🚀 MapBloc: Emitting loadSuccess state with ${spots.length} spots',
      );
      emit(
        MapState.loadSuccess(
          boundaryData: boundaryData,
          spots: spots,
          userVisitData: userAreaData,
          userSpotVisitData: {},
        ),
      );
      print('✅ MapBloc: State emitted successfully');
    } catch (e) {
      print('❌ MapBloc: Error in _onFetchDataRequested: $e');
      emit(MapState.loadFailure(error: e.toString()));
    }
  }

  Future<void> _onMapViewChanged(
    Emitter<MapState> emit,
  ) async {
    print('🗺️ MapBloc: _onMapViewChanged called');
    // Avoid refetching if we are already in a success state
    if (state is! _LoadSuccess) {
      print('⚠️ MapBloc: Not in success state, skipping map view change');
      return;
    }

    final currentState = state as _LoadSuccess;
    print('🔄 MapBloc: Current state has ${currentState.spots.length} spots');

    try {
      print('🎯 MapBloc: Fetching spots for map view change...');
      final spots = await _mapRepository.getSpots();
      print('✅ MapBloc: Fetched ${spots.length} spots, emitting updated state');
      emit(currentState.copyWith(spots: spots));
    } catch (e) {
      // We can choose to notify the user or just log the error
      // For now, we'll just print it and not change the state
      print('❌ MapBloc: Error fetching spots for new view: $e');
    }
  }

  /// Loads user area completion data from the database
  Future<Map<String, UserAreaData>> _loadUserAreaData(String userId) async {
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
