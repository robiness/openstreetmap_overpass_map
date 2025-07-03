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

/// Extension to calculate area exploration status
extension UserAreaDataExt on UserAreaData {
  /// Calculates the current exploration status of this area
  AreaExplorationStatus get status {
    if (totalSpots == null || totalSpots == 0) {
      return AreaExplorationStatus.noSpots;
    }
    if (visitedSpots == null || visitedSpots == 0) {
      return AreaExplorationStatus.unvisited;
    }
    if (visitedSpots! >= totalSpots!) {
      return AreaExplorationStatus.completed;
    }
    return AreaExplorationStatus.partial;
  }

  /// Returns true if the user has visited at least one spot in the area
  bool get isVisited => visitedSpots != null && visitedSpots! > 0;

  /// Returns completion percentage (0.0 to 1.0)
  double get completionPercentage {
    if (totalSpots == null || totalSpots == 0) return 0.0;
    if (visitedSpots == null) return 0.0;
    return (visitedSpots! / totalSpots!).clamp(0.0, 1.0);
  }

  /// Returns a user-friendly status description
  String get statusDescription {
    switch (status) {
      case AreaExplorationStatus.noSpots:
        return 'No spots available';
      case AreaExplorationStatus.unvisited:
        return 'Not yet explored';
      case AreaExplorationStatus.partial:
        return '${visitedSpots ?? 0}/${totalSpots ?? 0} spots visited';
      case AreaExplorationStatus.completed:
        return 'Fully explored!';
    }
  }
}
