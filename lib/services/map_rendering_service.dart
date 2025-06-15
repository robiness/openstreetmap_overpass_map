import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/osm_models.dart';
import '../widgets/animated_area_layer.dart';

/// Service for converting GeographicArea data to map display elements
class MapRenderingService {
  /// Create an animated area layer widget
  static Widget createAnimatedAreaLayer({
    required List<GeographicArea> areas,
    Map<String, Color>? colorsByType,
    Duration animationDuration = const Duration(milliseconds: 1000),
    Curve animationCurve = Curves.easeInOut,
    Map<int, ui.Shader>? shadersByAreaId,
    VoidCallback? onAnimationComplete,
    GeographicArea? selectedArea,
    Set<int>? visitedAreaIds, // Keep for backward compatibility
    Set<int>? completedAreaIds,
    Set<int>? partialAreaIds,
    Set<int>? unvisitedAreaIds,
    Color selectionColor = Colors.orange,
    Color visitedColor = Colors.purple, // Keep for backward compatibility
    Color completedColor = Colors.green,
    Color partialColor = Colors.amber,
    Color unvisitedColor = Colors.grey,
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
      completedAreaIds: completedAreaIds,
      partialAreaIds: partialAreaIds,
      unvisitedAreaIds: unvisitedAreaIds,
      selectionColor: selectionColor,
      visitedColor: visitedColor,
      completedColor: completedColor,
      partialColor: partialColor,
      unvisitedColor: unvisitedColor,
    );
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
}
