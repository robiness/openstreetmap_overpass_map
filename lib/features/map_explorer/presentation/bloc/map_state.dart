part of 'map_bloc.dart';

@freezed
class MapState with _$MapState {
  const factory MapState.initial() = _Initial;
  const factory MapState.loadInProgress() = _LoadInProgress;
  const factory MapState.loadSuccess({
    required BoundaryData boundaryData,
    required List<Spot> spots,
    GeographicArea? selectedArea,
    required Map<int, UserAreaData> userVisitData,
  }) = _LoadSuccess;
  const factory MapState.loadFailure({required String error}) = _LoadFailure;
}
