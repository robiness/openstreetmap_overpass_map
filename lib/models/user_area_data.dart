
class UserAreaData {
  final int areaId;
  int visitCount;
  // Add other user-specific fields here in the future
  // e.g., String userNotes;
  // e.g., bool isFavorite;

  UserAreaData({
    required this.areaId,
    this.visitCount = 0,
    // Initialize other fields
  });

  // Method to increment visit count
  void incrementVisitCount() {
    visitCount++;
  }

  // For persistence (e.g., with shared_preferences)
  Map<String, dynamic> toJson() {
    return {
      'areaId': areaId,
      'visitCount': visitCount,
      // Add other fields to JSON
    };
  }

  factory UserAreaData.fromJson(Map<String, dynamic> json) {
    return UserAreaData(
      areaId: json['areaId'] as int,
      visitCount: json['visitCount'] as int? ?? 0,
      // Extract other fields from JSON
    );
  }

  @override
  String toString() {
    return 'UserAreaData(areaId: $areaId, visitCount: $visitCount)';
  }
}
