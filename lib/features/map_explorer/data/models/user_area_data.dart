import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_area_data.freezed.dart';
part 'user_area_data.g.dart';

@freezed
class UserAreaData with _$UserAreaData {
  const factory UserAreaData({
    required int areaId,
    @Default(0) int visitCount,
    DateTime? lastVisited,
    int? totalSpots,
    int? visitedSpots,
    DateTime? firstSpotVisit,
    DateTime? completedAt,
  }) = _UserAreaData;

  factory UserAreaData.fromJson(Map<String, dynamic> json) =>
      _$UserAreaDataFromJson(json);
}

/// Area exploration status enum
enum AreaExplorationStatus {
  noSpots, // Area has no spots to explore
  unvisited, // Area has spots but none visited
  partial, // Some spots visited but not all
  completed, // All spots in area visited
}
