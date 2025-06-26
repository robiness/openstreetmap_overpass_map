import 'package:latlong2/latlong.dart';

class Spot {
  final int id;
  final String name;
  final String category;
  final LatLng location;
  final String? description;
  final List<String> tags;
  final DateTime createdAt;
  final String? createdBy;
  final Map<String, dynamic> properties; // For flexible OSM data

  // Optional area association
  final int? parentAreaId; // Which Stadtteil/Bezirk this spot belongs to

  Spot({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    this.description,
    this.tags = const [],
    required this.createdAt,
    this.createdBy,
    this.properties = const {},
    this.parentAreaId,
  });

  factory Spot.fromOsmNode(Map<String, dynamic> osmData) {
    final tags = Map<String, dynamic>.from(osmData['tags'] ?? {});

    return Spot(
      id: osmData['id'] as int,
      name: tags['name'] ?? 'Unnamed Spot',
      category: _categorizeFromTags(tags),
      location: LatLng(
        osmData['lat'] as double,
        osmData['lon'] as double,
      ),
      description: tags['description'],
      tags: _extractRelevantTags(tags),
      createdAt: DateTime.now(), // Or parse from OSM timestamp
      properties: tags,
    );
  }

  static String _categorizeFromTags(Map<String, dynamic> tags) {
    // Priority-based categorization logic
    if (tags.containsKey('amenity')) {
      final amenity = tags['amenity'];
      switch (amenity) {
        case 'restaurant':
          return 'restaurant';
        case 'bar':
          return 'bar';
        case 'cafe':
          return 'cafe';
        case 'biergarten':
          return 'biergarten';
        case 'fast_food':
          return 'fast_food';
        case 'pub':
          return 'pub';
        default:
          return 'amenity';
      }
    }
    if (tags.containsKey('tourism')) {
      return 'viewpoint';
    }
    if (tags.containsKey('shop')) {
      return 'shop';
    }
    return 'other';
  }

  static List<String> _extractRelevantTags(Map<String, dynamic> tags) {
    final relevantKeys = [
      'cuisine',
      'outdoor_seating',
      'beer_garden',
      'wheelchair',
    ];
    return relevantKeys
        .where((key) => tags.containsKey(key))
        .map((key) => '$key:${tags[key]}')
        .toList();
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category,
    'lat': location.latitude,
    'lon': location.longitude,
    'description': description,
    'tags': tags,
    'createdAt': createdAt.toIso8601String(),
    'createdBy': createdBy,
    'properties': properties,
    'parentAreaId': parentAreaId,
  };

  factory Spot.fromJson(Map<String, dynamic> json) => Spot(
    id: json['id'] as int,
    name: json['name'] as String,
    category: json['category'] as String,
    location: LatLng(json['lat'] as double, json['lon'] as double),
    description: json['description'] as String?,
    tags: List<String>.from(json['tags'] ?? []),
    createdAt: DateTime.parse(json['createdAt'] as String),
    createdBy: json['createdBy'] as String?,
    properties: Map<String, dynamic>.from(json['properties'] ?? {}),
    parentAreaId: json['parentAreaId'] as int?,
  );
}

// User interaction data for spots
class UserSpotData {
  final int spotId;
  int visitCount;
  bool isFavorite;
  DateTime? lastVisited;
  double? userRating; // 1-5 stars
  String? userNotes;

  UserSpotData({
    required this.spotId,
    this.visitCount = 0,
    this.isFavorite = false,
    this.lastVisited,
    this.userRating,
    this.userNotes,
  });

  void incrementVisitCount() {
    visitCount++;
    lastVisited = DateTime.now();
  }

  Map<String, dynamic> toJson() => {
    'spotId': spotId,
    'visitCount': visitCount,
    'isFavorite': isFavorite,
    'lastVisited': lastVisited?.toIso8601String(),
    'userRating': userRating,
    'userNotes': userNotes,
  };

  factory UserSpotData.fromJson(Map<String, dynamic> json) => UserSpotData(
    spotId: json['spotId'] as int,
    visitCount: json['visitCount'] as int? ?? 0,
    isFavorite: json['isFavorite'] as bool? ?? false,
    lastVisited: json['lastVisited'] != null
        ? DateTime.parse(json['lastVisited'] as String)
        : null,
    userRating: json['userRating'] as double?,
    userNotes: json['userNotes'] as String?,
  );
}

// Displayable spot combining spot data with user data
class DisplayableSpot {
  final Spot spot;
  final UserSpotData userData;

  DisplayableSpot({required this.spot, required this.userData});

  // Convenience getters
  int get id => spot.id;
  String get name => spot.name;
  String get category => spot.category;
  LatLng get location => spot.location;
  int get visitCount => userData.visitCount;
  bool get isFavorite => userData.isFavorite;
  bool get isVisited => userData.visitCount > 0;
}
