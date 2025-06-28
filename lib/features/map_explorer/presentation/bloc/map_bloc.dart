import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/data/repositories/map_repository.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';

part 'map_bloc.freezed.dart';
part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapRepository _mapRepository;

  MapBloc({required MapRepository mapRepository})
    : _mapRepository = mapRepository,
      super(const MapState.initial()) {
    on<MapEvent>((event, emit) async {
      await event.when(
        fetchDataRequested: (cityName, adminLevel) =>
            _onFetchDataRequested(emit, cityName, adminLevel),
        areaSelected: (area) => _onAreaSelected(emit, area),
        incrementAreaVisit: (areaId) => _onIncrementAreaVisit(emit, areaId),
        decrementAreaVisit: (areaId) => _onDecrementAreaVisit(emit, areaId),
        spotSelected: (spot) => _onSpotSelected(emit, spot),
        incrementSpotVisit: (spotId) => _onIncrementSpotVisit(emit, spotId),
        decrementSpotVisit: (spotId) => _onDecrementSpotVisit(emit, spotId),
      );
    });
  }

  Future<void> _onFetchDataRequested(
    Emitter<MapState> emit,
    String cityName,
    int adminLevel,
  ) async {
    emit(const MapState.loadInProgress());
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

      emit(
        MapState.loadSuccess(
          boundaryData: boundaryData,
          spots: spotsToShow,
          userVisitData: {}, // Start with empty visit data
          userSpotVisitData: {}, // Start with empty spot visit data
        ),
      );
    } catch (e) {
      emit(MapState.loadFailure(error: e.toString()));
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
    state.whenOrNull(
      loadSuccess:
          (
            boundaryData,
            spots,
            _,
            selectedSpot,
            userVisitData,
            userSpotVisitData,
          ) {
            emit(
              MapState.loadSuccess(
                boundaryData: boundaryData,
                spots: spots,
                selectedArea: area,
                selectedSpot: selectedSpot,
                userVisitData: userVisitData,
                userSpotVisitData: userSpotVisitData,
              ),
            );
          },
    );
  }

  Future<void> _onSpotSelected(
    Emitter<MapState> emit,
    Spot? spot,
  ) async {
    state.whenOrNull(
      loadSuccess:
          (
            boundaryData,
            spots,
            selectedArea,
            _,
            userVisitData,
            userSpotVisitData,
          ) {
            // If spot is tapped, also increment visit count
            final newSpotVisitData = Map<int, UserSpotData>.from(
              userSpotVisitData,
            );
            if (spot != null) {
              final currentData =
                  newSpotVisitData[spot.id] ?? UserSpotData(spotId: spot.id);
              newSpotVisitData[spot.id] = currentData.copyWith(
                visitCount: currentData.visitCount + 1,
                lastVisited: DateTime.now(),
              );
            }

            emit(
              MapState.loadSuccess(
                boundaryData: boundaryData,
                spots: spots,
                selectedArea: selectedArea,
                selectedSpot: spot,
                userVisitData: userVisitData,
                userSpotVisitData: newSpotVisitData,
              ),
            );
          },
    );
  }

  Future<void> _onIncrementAreaVisit(Emitter<MapState> emit, int areaId) async {
    state.whenOrNull(
      loadSuccess:
          (
            boundaryData,
            spots,
            selectedArea,
            selectedSpot,
            userVisitData,
            userSpotVisitData,
          ) {
            final newVisitData = Map<int, UserAreaData>.from(userVisitData);
            final currentData =
                newVisitData[areaId] ?? UserAreaData(areaId: areaId);
            newVisitData[areaId] = currentData.copyWith(
              visitCount: currentData.visitCount + 1,
            );
            emit(
              MapState.loadSuccess(
                boundaryData: boundaryData,
                spots: spots,
                selectedArea: selectedArea,
                selectedSpot: selectedSpot,
                userVisitData: newVisitData,
                userSpotVisitData: userSpotVisitData,
              ),
            );
          },
    );
  }

  Future<void> _onDecrementAreaVisit(Emitter<MapState> emit, int areaId) async {
    state.whenOrNull(
      loadSuccess:
          (
            boundaryData,
            spots,
            selectedArea,
            selectedSpot,
            userVisitData,
            userSpotVisitData,
          ) {
            final newVisitData = Map<int, UserAreaData>.from(userVisitData);
            final currentData =
                newVisitData[areaId] ?? UserAreaData(areaId: areaId);
            newVisitData[areaId] = currentData.copyWith(
              visitCount: currentData.visitCount - 1,
            );
            emit(
              MapState.loadSuccess(
                boundaryData: boundaryData,
                spots: spots,
                selectedArea: selectedArea,
                selectedSpot: selectedSpot,
                userVisitData: newVisitData,
                userSpotVisitData: userSpotVisitData,
              ),
            );
          },
    );
  }

  Future<void> _onIncrementSpotVisit(Emitter<MapState> emit, int spotId) async {
    state.whenOrNull(
      loadSuccess:
          (
            boundaryData,
            spots,
            selectedArea,
            selectedSpot,
            userVisitData,
            userSpotVisitData,
          ) {
            final newSpotVisitData = Map<int, UserSpotData>.from(
              userSpotVisitData,
            );
            final currentData =
                newSpotVisitData[spotId] ?? UserSpotData(spotId: spotId);
            newSpotVisitData[spotId] = currentData.copyWith(
              visitCount: currentData.visitCount + 1,
            );
            emit(
              MapState.loadSuccess(
                boundaryData: boundaryData,
                spots: spots,
                selectedArea: selectedArea,
                selectedSpot: selectedSpot,
                userVisitData: userVisitData,
                userSpotVisitData: newSpotVisitData,
              ),
            );
          },
    );
  }

  Future<void> _onDecrementSpotVisit(Emitter<MapState> emit, int spotId) async {
    state.whenOrNull(
      loadSuccess:
          (
            boundaryData,
            spots,
            selectedArea,
            selectedSpot,
            userVisitData,
            userSpotVisitData,
          ) {
            final newSpotVisitData = Map<int, UserSpotData>.from(
              userSpotVisitData,
            );
            final currentData =
                newSpotVisitData[spotId] ?? UserSpotData(spotId: spotId);
            newSpotVisitData[spotId] = currentData.copyWith(
              visitCount: currentData.visitCount - 1,
            );
            emit(
              MapState.loadSuccess(
                boundaryData: boundaryData,
                spots: spots,
                selectedArea: selectedArea,
                selectedSpot: selectedSpot,
                userVisitData: userVisitData,
                userSpotVisitData: newSpotVisitData,
              ),
            );
          },
    );
  }
}
