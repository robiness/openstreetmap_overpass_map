import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';

part 'map_event.freezed.dart';

@freezed
class MapEvent with _$MapEvent {
  const factory MapEvent.fetchDataRequested({
    required String cityName,
    required int adminLevel,
  }) = _FetchDataRequested;

  const factory MapEvent.areaSelected({required GeographicArea area}) =
      _AreaSelected;

  const factory MapEvent.incrementAreaVisit({required int areaId}) =
      _IncrementAreaVisit;

  const factory MapEvent.decrementAreaVisit({required int areaId}) =
      _DecrementAreaVisit;

  // We can add more events here later (e.g., SelectArea, SelectSpot)
}
