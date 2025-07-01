part of 'map_bloc.dart';

@freezed
class MapEvent with _$MapEvent {
  const factory MapEvent.fetchDataRequested({
    required String cityName,
    required int adminLevel,
    String? userId,
  }) = _FetchDataRequested;

  const factory MapEvent.areaSelected({GeographicArea? area}) = _AreaSelected;

  const factory MapEvent.spotSelected({Spot? spot}) = _SpotSelected;

  const factory MapEvent.refreshAreaDataRequested({
    required String userId,
  }) = _RefreshAreaDataRequested;
}
