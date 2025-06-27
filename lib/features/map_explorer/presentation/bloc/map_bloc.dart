import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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

      final spots = await _mapRepository.getSpots(cityName: cityName);

      emit(
        MapState.loadSuccess(
          boundaryData: boundaryData,
          spots: spots,
          userVisitData: {}, // Start with empty visit data
        ),
      );
    } catch (e) {
      emit(MapState.loadFailure(error: e.toString()));
    }
  }

  Future<void> _onAreaSelected(
    Emitter<MapState> emit,
    GeographicArea? area,
  ) async {
    state.whenOrNull(
      loadSuccess: (boundaryData, spots, _, userVisitData) {
        emit(
          MapState.loadSuccess(
            boundaryData: boundaryData,
            spots: spots,
            selectedArea: area,
            userVisitData: userVisitData,
          ),
        );
      },
    );
  }

  Future<void> _onIncrementAreaVisit(Emitter<MapState> emit, int areaId) async {
    state.whenOrNull(
      loadSuccess: (boundaryData, spots, selectedArea, userVisitData) {
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
            userVisitData: newVisitData,
          ),
        );
      },
    );
  }

  Future<void> _onDecrementAreaVisit(Emitter<MapState> emit, int areaId) async {
    state.whenOrNull(
      loadSuccess: (boundaryData, spots, selectedArea, userVisitData) {
        final newVisitData = Map<int, UserAreaData>.from(userVisitData);
        final currentData = newVisitData[areaId];
        if (currentData != null && currentData.visitCount > 0) {
          newVisitData[areaId] = currentData.copyWith(
            visitCount: currentData.visitCount - 1,
          );
          emit(
            MapState.loadSuccess(
              boundaryData: boundaryData,
              spots: spots,
              selectedArea: selectedArea,
              userVisitData: newVisitData,
            ),
          );
        }
      },
    );
  }
}
