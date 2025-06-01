import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:ui' as ui;

import '../models/osm_models.dart';
import '../overpass_map_notifier.dart'; // Import DisplayableArea
import '../widgets/animated_area_layer.dart';
import '../widgets/custom_area_painter.dart';

/// Service for converting GeographicArea data to map display elements
class MapRenderingService {
  /// Convert GeographicArea to Flutter Map Polygon (legacy method)
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

  /// Convert multiple areas to polygons with consistent styling (legacy method)
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

  /// Create an animated area layer widget
  static Widget createAnimatedAreaLayer({
    required List<GeographicArea> areas,
    Map<String, Color>? colorsByType,
    Duration animationDuration = const Duration(milliseconds: 1000),
    Curve animationCurve = Curves.easeInOut,
    bool enableAnimation = true,
    Map<int, ui.Shader>? shadersByAreaId,
    VoidCallback? onAnimationComplete,
  }) {
    return AnimatedAreaLayer(
      areas: areas,
      colorsByType: colorsByType,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      enableAnimation: enableAnimation,
      shadersByAreaId: shadersByAreaId,
      onAnimationComplete: onAnimationComplete,
    );
  }

  /// Create animated areas with custom styling
  static List<AnimatedArea> createAnimatedAreas({
    required List<GeographicArea> areas,
    Map<String, Color>? colorsByType,
    Map<int, Color>? fillColorOverrides,
    Map<int, Color>? borderColorOverrides,
    Map<int, double>? opacityOverrides,
    Map<int, ui.Shader>? shadersByAreaId,
    double defaultBorderWidth = 2.0,
    double defaultFillOpacity = 0.3,
  }) {
    return areas.map((area) {
      final defaultColor = colorsByType?[area.type] ?? _getDefaultColor(area.type);
      
      return AnimatedArea(
        geoArea: area,
        fillColor: fillColorOverrides?[area.id] ?? defaultColor,
        borderColor: borderColorOverrides?[area.id] ?? defaultColor.withOpacity(0.8),
        fillOpacity: opacityOverrides?[area.id] ?? defaultFillOpacity,
        borderWidth: defaultBorderWidth,
        shader: shadersByAreaId?[area.id],
      );
    }).toList();
  }

  /// Create shaders for specific animation effects
  static Map<int, ui.Shader> createAnimationShaders({
    required List<GeographicArea> areas,
    required Size screenSize,
    String shaderType = 'gradient',
  }) {
    final Map<int, ui.Shader> shaders = {};
    
    for (final area in areas) {
      switch (shaderType) {
        case 'gradient':
          shaders[area.id] = ui.Gradient.linear(
            const Offset(0, 0),
            Offset(screenSize.width, screenSize.height),
            [
              _getDefaultColor(area.type).withOpacity(0.1),
              _getDefaultColor(area.type).withOpacity(0.6),
            ],
          );
          break;
        case 'radial':
          shaders[area.id] = ui.Gradient.radial(
            Offset(screenSize.width / 2, screenSize.height / 2),
            screenSize.width / 3,
            [
              _getDefaultColor(area.type).withOpacity(0.8),
              _getDefaultColor(area.type).withOpacity(0.2),
            ],
          );
          break;
        case 'sweep':
          shaders[area.id] = ui.Gradient.sweep(
            Offset(screenSize.width / 2, screenSize.height / 2),
            [
              _getDefaultColor(area.type),
              _getDefaultColor(area.type).withOpacity(0.3),
              _getDefaultColor(area.type),
            ],
          );
          break;
      }
    }
    
    return shaders;
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
