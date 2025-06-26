import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';

/// A custom painter for drawing geographic areas with animation support
class CustomAreaPainter extends CustomPainter {
  final List<GeographicArea> areas;
  final MapCamera camera;

  CustomAreaPainter({required this.areas, required this.camera});

  @override
  void paint(Canvas canvas, Size size) {
    for (final animatedArea in areas) {
      _paintArea(canvas, size, animatedArea);
    }
  }

  void _paintArea(Canvas canvas, Size size, GeographicArea area) {
    // Convert coordinates to screen points and draw
    for (final coordinateRing in area.coordinates) {
      final path = _createPathFromCoordinates(coordinateRing);

      if (path != null) {
        canvas.drawPath(
          path,
          Paint()
            ..color = Colors.black.withValues(alpha: 1)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
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
    return oldDelegate.areas != areas || oldDelegate.camera != camera;
  }

  @override
  bool hitTest(Offset position) => false;
}
