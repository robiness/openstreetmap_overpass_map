part of 'map_bloc.dart';

@freezed
class MapState with _$MapState {
  const factory MapState.initial() = _Initial;
  const factory MapState.loadInProgress() = _LoadInProgress;
  const factory MapState.loadSuccess({
    required BoundaryData boundaryData,
    required List<Spot> spots,
    GeographicArea? selectedArea,
    Spot? selectedSpot,
    required Map<int, UserAreaData> userVisitData,
    required Map<int, UserSpotData> userSpotVisitData,
    @Default(false) bool isDebugModeEnabled,
  }) = _LoadSuccess;
  const factory MapState.loadFailure({required String error}) = _LoadFailure;
}
