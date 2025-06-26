import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';

part 'map_state.freezed.dart';

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
