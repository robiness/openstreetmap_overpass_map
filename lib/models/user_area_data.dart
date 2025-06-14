class UserAreaData {
  final int areaId;
  int visitCount;
  DateTime? lastVisitedAt;

  // Area exploration state
  int totalSpots;
  int visitedSpots;
  DateTime? firstSpotVisit;
  DateTime? completedAt;

  // Add other user-specific fields here in the future
  // e.g., String userNotes;
  // e.g., bool isFavorite;

  UserAreaData({
    required this.areaId,
    this.visitCount = 0,
    this.lastVisitedAt,
    this.totalSpots = 0,
    this.visitedSpots = 0,
    this.firstSpotVisit,
    this.completedAt,
  });

  // Method to increment visit count
  void incrementVisitCount() {
    visitCount++;
    lastVisitedAt = DateTime.now();
  }

  /// Update spot exploration data
  void updateSpotExploration({
    required int totalSpotsInArea,
    required int visitedSpotsInArea,
  }) {
    totalSpots = totalSpotsInArea;
    final previousVisitedSpots = visitedSpots;
    visitedSpots = visitedSpotsInArea;

    // Track first spot visit
    if (previousVisitedSpots == 0 && visitedSpots > 0) {
      firstSpotVisit = DateTime.now();
    }

    // Track area completion
    if (totalSpots > 0 && visitedSpots == totalSpots && completedAt == null) {
      completedAt = DateTime.now();
    }

    // Reset completion if spots were removed (shouldn't happen normally)
    if (visitedSpots < totalSpots) {
      completedAt = null;
    }
  }

  /// Get area exploration status
  AreaExplorationStatus get explorationStatus {
    if (totalSpots == 0) return AreaExplorationStatus.noSpots;
    if (visitedSpots == 0) return AreaExplorationStatus.unvisited;
    if (visitedSpots == totalSpots) return AreaExplorationStatus.completed;
    return AreaExplorationStatus.partial;
  }

  /// Get completion percentage (0.0 to 1.0)
  double get completionPercentage {
    if (totalSpots == 0) return 0.0;
    return visitedSpots / totalSpots;
  }

  /// Check if area has any progress
  bool get hasProgress => visitedSpots > 0;

  /// Check if area is fully completed
  bool get isCompleted => explorationStatus == AreaExplorationStatus.completed;

  // For persistence (e.g., with shared_preferences)
  Map<String, dynamic> toJson() {
    return {
      'areaId': areaId,
      'visitCount': visitCount,
      'lastVisitedAt': lastVisitedAt?.toIso8601String(),
      'totalSpots': totalSpots,
      'visitedSpots': visitedSpots,
      'firstSpotVisit': firstSpotVisit?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory UserAreaData.fromJson(Map<String, dynamic> json) {
    return UserAreaData(
      areaId: json['areaId'] as int,
      visitCount: json['visitCount'] as int? ?? 0,
      lastVisitedAt: json['lastVisitedAt'] != null
          ? DateTime.parse(json['lastVisitedAt'] as String)
          : null,
      totalSpots: json['totalSpots'] as int? ?? 0,
      visitedSpots: json['visitedSpots'] as int? ?? 0,
      firstSpotVisit: json['firstSpotVisit'] != null
          ? DateTime.parse(json['firstSpotVisit'] as String)
          : null,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  @override
  String toString() {
    return 'UserAreaData(areaId: $areaId, visitCount: $visitCount)';
  }
}

/// Area exploration status enum
enum AreaExplorationStatus {
  noSpots, // Area has no spots to explore
  unvisited, // Area has spots but none visited
  partial, // Some spots visited but not all
  completed, // All spots in area visited
}
