// OSM model classes for Overpass parser
class OsmPoint {
  final double lat;
  final double lon;

  OsmPoint({required this.lat, required this.lon});

  factory OsmPoint.fromJson(Map<String, dynamic> json) {
    return OsmPoint(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );
  }
}

class OsmWay {
  final int id;
  final List<OsmPoint> geometry;

  OsmWay({required this.id, required this.geometry});

  factory OsmWay.fromJson(Map<String, dynamic> json) {
    var geometryList = (json['geometry'] as List)
        .map((point) => OsmPoint.fromJson(point))
        .toList();
    return OsmWay(
      id: json['id'] as int,
      geometry: geometryList,
    );
  }
}

class OsmRelationMember {
  final String type;
  final int ref;
  final String role;

  OsmRelationMember({
    required this.type,
    required this.ref,
    required this.role,
  });

  factory OsmRelationMember.fromJson(Map<String, dynamic> json) {
    return OsmRelationMember(
      type: json['type'] as String,
      ref: json['ref'] as int,
      role: json['role'] as String,
    );
  }
}

class OsmRelation {
  final int id;
  final Map<String, dynamic> tags;
  final List<OsmRelationMember> members;

  OsmRelation({required this.id, required this.tags, required this.members});

  factory OsmRelation.fromJson(Map<String, dynamic> json) {
    var membersList = (json['members'] as List)
        .map((member) => OsmRelationMember.fromJson(member))
        .toList();
    return OsmRelation(
      id: json['id'] as int,
      tags: Map<String, dynamic>.from(json['tags'] ?? {}),
      members: membersList,
    );
  }
}

class GeographicArea {
  final int id;
  final String name;
  final String type;
  final int adminLevel;
  final List<List<List<double>>> coordinates;
  int? totalSpots;

  GeographicArea({
    required this.id,
    required this.name,
    required this.type,
    required this.adminLevel,
    required this.coordinates,
    this.totalSpots,
  });
}
