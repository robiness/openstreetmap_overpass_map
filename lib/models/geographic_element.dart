import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Base class for any geographic element in the game.
class GeographicElement {
  final String osmId; // OSM relation ID or way ID
  final String name;
  final Map<String, String> tags; // OSM tags
  final List<Polygon> polygons;
  final LatLng? center; // Calculated center for label display

  GeographicElement({
    required this.osmId,
    required this.name,
    required this.tags,
    required this.polygons,
    this.center,
  });

  // Method to calculate the center if not provided,
  // can be overridden by subclasses for more specific calculations.
  LatLng calculateCenter() {
    if (center != null) return center!; // Return pre-calculated center if available

    if (polygons.isEmpty || polygons.first.points.isEmpty) {
      return LatLng(0, 0); // Default or throw error
    }
    // Simple average for now, could be more sophisticated (e.g., centroid)
    double lat = 0;
    double lng = 0;
    int pointCount = 0;
    for (var polygon in polygons) {
      for (var point in polygon.points) {
        lat += point.latitude;
        lng += point.longitude;
        pointCount++;
      }
    }
    if (pointCount == 0) return LatLng(0,0);
    return LatLng(lat / pointCount, lng / pointCount);
  }
}

/// Represents a city.
class CityElement extends GeographicElement {
  final int adminLevel;

  CityElement({
    required String osmId,
    required String name,
    required Map<String, String> tags,
    required List<Polygon> polygons,
    required this.adminLevel,
    LatLng? center,
  }) : super(osmId: osmId, name: name, tags: tags, polygons: polygons, center: center ?? GeographicElement(osmId: osmId, name: name, tags: tags, polygons: polygons).calculateCenter());
}

/// Represents a district or sub-region within a city.
class DistrictElement extends GeographicElement {
  final String parentCityId; // OSM ID of the parent city
  final int adminLevel;

  DistrictElement({
    required String osmId,
    required String name,
    required Map<String, String> tags,
    required List<Polygon> polygons,
    required this.parentCityId,
    required this.adminLevel,
    LatLng? center,
  }) : super(osmId: osmId, name: name, tags: tags, polygons: polygons, center: center ?? GeographicElement(osmId: osmId, name: name, tags: tags, polygons: polygons).calculateCenter());
}

/// Represents a custom, user-defined location.
class CustomLocationElement extends GeographicElement {
  final String description;
  // Potentially other custom properties like unlock cost, rewards, etc.

  CustomLocationElement({
    required String osmId, // Could be a generated ID if not from OSM
    required String name,
    required Map<String, String> tags, // Might be empty or custom
    required List<Polygon> polygons, // Could be a single point or a drawn area
    required this.description,
    LatLng? center,
  }) : super(osmId: osmId, name: name, tags: tags, polygons: polygons, center: center ?? GeographicElement(osmId: osmId, name: name, tags: tags, polygons: polygons).calculateCenter());
}
