import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/osm_models.dart';

/// Service for converting GeographicArea data to map display elements
class MapRenderingService {
  /// Convert GeographicArea to Flutter Map Polygon
  static Polygon areaToPolygon(GeographicArea area, {Color? color, double? borderWidth}) {
    final Color polygonColor = color ?? _getDefaultColor(area.type);

    return Polygon(
      points: _coordinatesToLatLng(area.coordinates),
      color: polygonColor.withOpacity(0.3),
      borderColor: polygonColor,
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
    if (coordinates.isEmpty) return const LatLng(50.9, 6.9); // Cologne default

    final outerRing = coordinates.first;
    if (outerRing.isEmpty) return const LatLng(50.9, 6.9);

    double sumLat = 0;
    double sumLng = 0;
    int count = 0;

    for (final coord in outerRing) {
      sumLng += coord[0];
      sumLat += coord[1];
      count++;
    }

    return LatLng(sumLat / count, sumLng / count);
  }

  static Widget _defaultMarker(GeographicArea area) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _getDefaultColor(area.type)),
      ),
      child: Text(
        area.name,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: _getDefaultColor(area.type),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
