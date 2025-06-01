import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/osm_models.dart';
import '../overpass_map_notifier.dart'; // Import DisplayableArea

/// Service for converting GeographicArea data to map display elements
class MapRenderingService {
  /// Convert GeographicArea to Flutter Map Polygon
  static Polygon areaToPolygon(GeographicArea area, {Color? color, double? borderWidth}) {
    final Color polygonColor = color ?? _getDefaultColor(area.type);

    return Polygon(
      points: _coordinatesToLatLng(area.coordinates),
      color: polygonColor.withOpacity(0.3),
      borderColor: Colors.black,
      borderStrokeWidth: borderWidth ?? 2.0,
      label: area.name,
      labelStyle: TextStyle(
        color: polygonColor.withOpacity(0.8),
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
  }

  /// Convert multiple areas to polygons with consistent styling
  static List<Polygon> areasToPolygons(
    List<GeographicArea> areas, {
    Map<String, Color>? colorsByType,
    double? borderWidth,
  }) {
    return areas.map((area) {
      final color = colorsByType?[area.type] ?? _getDefaultColor(area.type);
      return areaToPolygon(area, color: color, borderWidth: borderWidth);
    }).toList();
  }

  /// Create markers for area labels/centers
  static List<Marker> createAreaMarkers(
    List<GeographicArea> areas, {
    Widget Function(GeographicArea)? markerBuilder,
  }) {
    return areas.map((area) {
      final center = _calculateCenterPoint(area.coordinates);
      return Marker(
        point: center,
        child: markerBuilder?.call(area) ?? _defaultMarker(area),
        width: 100,
        height: 30,
      );
    }).toList();
  }

  /// Create markers for area labels/centers, potentially using visit counts
  static List<Marker> createAreaMarkersWithVisits(
    List<DisplayableArea> displayableAreas, {
    // You can add a custom builder that also receives UserAreaData or visitCount
    Widget Function(DisplayableArea)? markerBuilder,
  }) {
    return displayableAreas.map((displayArea) {
      // Use geoArea for coordinates and name, userArea.visitCount for potential styling/info
      final center = _calculateCenterPoint(displayArea.geoArea.coordinates);
      // Example: Modify marker based on visit count
      // Color markerColor = displayArea.visitCount > 0 ? Colors.purple : Colors.orange;
      return Marker(
        point: center,
        child:
            markerBuilder?.call(displayArea) ?? _defaultMarker(displayArea.geoArea, visitCount: displayArea.visitCount),
        width: 120, // Adjusted width for potentially more info
        height: 40, // Adjusted height
      );
    }).toList();
  }

  /// Calculate bounds for fitting all areas on map
  static LatLngBounds calculateBounds(List<GeographicArea> areas) {
    if (areas.isEmpty) {
      // Default to Cologne if no areas
      return LatLngBounds(
        const LatLng(50.8, 6.8),
        const LatLng(51.0, 7.1),
      );
    }

    double minLat = double.infinity;
    double maxLat = double.negativeInfinity;
    double minLng = double.infinity;
    double maxLng = double.negativeInfinity;

    for (final area in areas) {
      for (final ring in area.coordinates) {
        for (final coord in ring) {
          final lng = coord[0];
          final lat = coord[1];

          minLat = minLat < lat ? minLat : lat;
          maxLat = maxLat > lat ? maxLat : lat;
          minLng = minLng < lng ? minLng : lng;
          maxLng = maxLng > lng ? maxLng : lng;
        }
      }
    }

    return LatLngBounds(
      LatLng(minLat, minLng),
      LatLng(maxLat, maxLng),
    );
  }

  // Private helper methods
  static Color _getDefaultColor(String type) {
    switch (type) {
      case 'city':
        return Colors.red;
      case 'bezirk':
        return Colors.blue;
      case 'stadtteil':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  static List<LatLng> _coordinatesToLatLng(List<List<List<double>>> coordinates) {
    if (coordinates.isEmpty) return [];

    // Use the first (longest) coordinate ring as the main polygon outline
    // This should be the combined outer boundary from our parser
    final mainRing = coordinates.isNotEmpty ? coordinates.first : <List<double>>[];

    return mainRing.map((coord) => LatLng(coord[1], coord[0])).toList();
  }

  static LatLng _calculateCenterPoint(List<List<List<double>>> coordinates) {
    if (coordinates.isEmpty || coordinates.first.isEmpty) {
      return const LatLng(0, 0); // Fallback
    }
    double latSum = 0;
    double lngSum = 0;
    int pointCount = 0;
    for (final ring in coordinates) {
      for (final coord in ring) {
        lngSum += coord[0];
        latSum += coord[1];
        pointCount++;
      }
    }
    if (pointCount == 0) return const LatLng(0, 0);
    return LatLng(latSum / pointCount, lngSum / pointCount);
  }

  static Widget _defaultMarker(GeographicArea area, {int? visitCount}) {
    String label = area.name;
    if (visitCount != null && visitCount > 0) {
      label += ' (Visits: $visitCount)';
    }
    return Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        color: Colors.black45,
        fontWeight: FontWeight.bold,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
