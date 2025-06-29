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
        spotSelected: (spot) => _onSpotSelected(emit, spot),
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
    final currentState = state as _LoadSuccess;

    GeographicArea? parentArea;
    if (spot != null) {
      // Find the area that this spot belongs to
      for (final area in currentState.boundaryData.stadtteile) {
        for (final polygonRing in area.coordinates) {
          final polygonLatLng = polygonRing
              .map((coords) => LatLng(coords[1], coords[0]))
              .toList();
          if (_isPointInPolygon(spot.location, polygonLatLng)) {
            parentArea = area;
            break;
          }
        }
        if (parentArea != null) break;
      }
    }

    emit(currentState.copyWith(selectedSpot: spot, selectedArea: parentArea));
  }
}
