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
    final isVisited = areaVisitData != null && areaVisitData.visitCount > 0;

    // Convert coordinates to screen points and draw
    for (final coordinateRing in area.coordinates) {
      final path = _createPathFromCoordinates(coordinateRing);

      if (path != null) {
        // Draw the fill
        Color fillColor;
        if (isSelected) {
          fillColor = Colors.blue.withAlpha(77);
        } else if (isVisited) {
          fillColor = Colors.purple.withAlpha(77);
        } else {
          fillColor = Colors.transparent;
        }

        if (fillColor != Colors.transparent) {
          canvas.drawPath(
            path,
            Paint()
              ..color = fillColor
              ..style = PaintingStyle.fill,
          );
        }

        // Draw the border
        Color borderColor;
        if (isSelected) {
          borderColor = Colors.blue;
        } else if (isVisited) {
          borderColor = Colors.purple;
        } else {
          borderColor = Colors.black;
        }

        canvas.drawPath(
          path,
          Paint()
            ..color = borderColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = isSelected ? 3.0 : (isVisited ? 2.5 : 2.0)
            ..strokeJoin = StrokeJoin.round
            ..strokeCap = StrokeCap.round,
        );
      }
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
