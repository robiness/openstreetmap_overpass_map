import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/osm_models.dart';
import '../overpass_map_notifier.dart'; // Import DisplayableArea
import '../theme/app_theme.dart';
import '../widgets/animated_area_layer.dart';
import '../widgets/custom_area_painter.dart';

/// Service for converting GeographicArea data to map display elements
class MapRenderingService {
  // Removed legacy polygon methods since we only use animated rendering now

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
            markerBuilder?.call(displayArea) ??
            _defaultMarker(
              displayArea.geoArea,
              visitCount: displayArea.visitCount,
            ),
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
    Map<int, ui.Shader>? shadersByAreaId,
    VoidCallback? onAnimationComplete,
    GeographicArea? selectedArea,
    Set<int>? visitedAreaIds,
    Color selectionColor = Colors.orange,
    Color visitedColor = Colors.purple,
  }) {
    return AnimatedAreaLayer(
      areas: areas,
      colorsByType: colorsByType,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      shadersByAreaId: shadersByAreaId,
      onAnimationComplete: onAnimationComplete,
      selectedArea: selectedArea,
      visitedAreaIds: visitedAreaIds,
      selectionColor: selectionColor,
      visitedColor: visitedColor,
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
    double defaultFillOpacity = 0.0, // Changed to transparent by default
    GeographicArea? selectedArea,
    Set<int>? visitedAreaIds,
    Color selectionColor = Colors.orange,
    Color visitedColor = Colors.purple,
  }) {
    return areas.map((area) {
      final defaultColor = colorsByType?[area.type] ?? _getDefaultColor(area.type);

      // Determine fill color based on state
      Color fillColor;
      double fillOpacity;

      if (selectedArea?.id == area.id) {
        // Selected area gets selection color
        fillColor = selectionColor;
        fillOpacity = 0.3;
      } else if (visitedAreaIds?.contains(area.id) == true) {
        // Visited area gets visited color
        fillColor = visitedColor;
        fillOpacity = 0.2;
      } else {
        // Default transparent fill
        fillColor = fillColorOverrides?[area.id] ?? defaultColor;
        fillOpacity = opacityOverrides?[area.id] ?? defaultFillOpacity;
      }

      return AnimatedArea(
        geoArea: area,
        fillColor: fillColor,
        borderColor: borderColorOverrides?[area.id] ?? defaultColor.withValues(alpha: 0.8),
        fillOpacity: fillOpacity,
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
        return AppTheme.getCityColor();
      case 'bezirk':
        return AppTheme.getBezirkColor();
      case 'stadtteil':
        return AppTheme.getStadtteilColor();
      default:
        return AppTheme.textSecondary;
    }
  }

  // Removed _coordinatesToLatLng method since we only use animated rendering now

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
