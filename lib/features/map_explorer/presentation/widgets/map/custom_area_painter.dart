import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';

/// A custom painter for drawing geographic areas with animation support
class CustomAreaPainter extends CustomPainter {
  final List<GeographicArea> areas;
  final MapCamera camera;
  final GeographicArea? selectedArea;
  final Map<int, UserAreaData> userVisitData;

  CustomAreaPainter({
    required this.areas,
    required this.camera,
    this.selectedArea,
    this.userVisitData = const {},
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Debug log only when we have area data
    if (userVisitData.isNotEmpty) {
      print(
        '🎨 Painting ${areas.length} areas with ${userVisitData.length} completed areas',
      );
    }

    // First pass: draw all non-selected areas
    for (final area in areas) {
      final isSelected = area.id == selectedArea?.id;
      if (!isSelected) {
        _paintArea(canvas, size, area, false);
      }
    }

    // Second pass: draw selected area on top
    if (selectedArea != null) {
      _paintArea(canvas, size, selectedArea!, true);
    }
  }

  void _paintArea(
    Canvas canvas,
    Size size,
    GeographicArea area,
    bool isSelected,
  ) {
    final areaVisitData = userVisitData[area.id];

    // Convert coordinates to screen points and draw
    for (final coordinateRing in area.coordinates) {
      final path = _createPathFromCoordinates(coordinateRing);

      if (path != null) {
        // Determine colors based on exploration status
        final colors = _getAreaColors(areaVisitData, isSelected);

        // Draw the fill
        if (colors.fill != Colors.transparent) {
          canvas.drawPath(
            path,
            Paint()
              ..color = colors.fill
              ..style = PaintingStyle.fill,
          );
        }

        // Draw the border
        canvas.drawPath(
          path,
          Paint()
            ..color = colors.border
            ..style = PaintingStyle.stroke
            ..strokeWidth = colors.strokeWidth
            ..strokeJoin = StrokeJoin.round
            ..strokeCap = StrokeCap.round,
        );
      }
    }
  }

  /// Gets appropriate colors based on area exploration status
  _AreaColors _getAreaColors(UserAreaData? areaData, bool isSelected) {
    if (isSelected) {
      return _AreaColors(
        fill: Colors.blue.withAlpha(120),
        border: Colors.blue,
        strokeWidth: 4.0,
      );
    }

    if (areaData == null) {
      // No data available - default appearance (light grey)
      return _AreaColors(
        fill: Colors.grey.withAlpha(20),
        border: Colors.grey.withAlpha(100),
        strokeWidth: 1.5,
      );
    }

    // Use vibrant colors for clear visual distinction
    switch (areaData.status) {
      case AreaExplorationStatus.noSpots:
      case AreaExplorationStatus.unvisited:
        // Medium grey for areas with no spots OR unvisited areas
        // Both represent neutral/initial state, not error state
        return _AreaColors(
          fill: Colors.grey.withAlpha(20),
          border: Colors.grey.withAlpha(100),
          strokeWidth: 1.5,
        );
      case AreaExplorationStatus.partial:
        // Vibrant orange for partially completed areas
        return _AreaColors(
          fill: Colors.orange.withAlpha(100),
          border: Colors.orange.shade600,
          strokeWidth: 2.5,
        );
      case AreaExplorationStatus.completed:
        // Bright green for fully completed areas
        return _AreaColors(
          fill: Colors.green.withAlpha(120),
          border: Colors.green.shade600,
          strokeWidth: 3.0,
        );
    }
  }

  ui.Path? _createPathFromCoordinates(
    List<List<double>> coordinates,
  ) {
    if (coordinates.isEmpty) return null;

    final path = ui.Path();
    bool isFirstPoint = true;

    for (final coord in coordinates) {
      final lng = coord[0];
      final lat = coord[1];

      // Convert lat/lng to screen coordinates
      final screenPoint = camera.latLngToScreenOffset(LatLng(lat, lng));

      if (isFirstPoint) {
        path.moveTo(screenPoint.dx, screenPoint.dy);
        isFirstPoint = false;
      } else {
        path.lineTo(screenPoint.dx, screenPoint.dy);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldRepaint(CustomAreaPainter oldDelegate) {
    return oldDelegate.areas != areas ||
        oldDelegate.camera != camera ||
        oldDelegate.selectedArea != selectedArea ||
        oldDelegate.userVisitData != userVisitData;
  }

  @override
  bool hitTest(Offset position) => false;
}

/// Helper class for area colors
class _AreaColors {
  final Color fill;
  final Color border;
  final double strokeWidth;

  _AreaColors({
    required this.fill,
    required this.border,
    required this.strokeWidth,
  });
}
