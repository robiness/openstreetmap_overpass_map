part of 'map_bloc.dart';

@freezed
sealed class MapState with _$MapState {
  const factory MapState.initial() = _Initial;
  const factory MapState.loadInProgress() = _LoadInProgress;
  const factory MapState.loadSuccess({
    required BoundaryData boundaryData,
    required List<Spot> spots,
    required Map<String, UserAreaData> userVisitData,
    required Map<String, UserSpotData> userSpotVisitData,
    GeographicArea? selectedArea,
    Spot? selectedSpot,
  }) = _LoadSuccess;
  const factory MapState.loadFailure({required String error}) = _LoadFailure;
}
