import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../data/osm_models.dart';

/// A custom painter for drawing geographic areas with animation support
class CustomAreaPainter extends CustomPainter {
  final List<AnimatedArea> areas;
  final MapCamera camera;
  final Animation<double>? animation;

  CustomAreaPainter({required this.areas, required this.camera, this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.clipRect(rect);
    for (final animatedArea in areas) {
      _paintArea(canvas, size, animatedArea);
    }
  }

  void _paintArea(Canvas canvas, Size size, AnimatedArea animatedArea) {
    final area = animatedArea.geoArea;
    final animationValue = animation?.value ?? 1.0;

    // Create animated paint for border
    final borderPaint = Paint()
      ..color =
          Color.lerp(
            animatedArea.borderColor.withValues(alpha: 0.0),
            animatedArea.borderColor,
            animationValue,
          ) ??
          animatedArea.borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = animatedArea.borderWidth * animationValue
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    // Convert coordinates to screen points and draw
    for (final coordinateRing in area.coordinates) {
      final path = _createPathFromCoordinates(coordinateRing, size);

      if (path != null) {
        canvas.drawPath(path, borderPaint);
        canvas.drawPath(
          path,
          Paint()
            ..color = Colors.green.withOpacity(0.5)
            ..strokeWidth = animatedArea.borderWidth * animationValue,
        );
      }
    }
  }

  ui.Path? _createPathFromCoordinates(
    List<List<double>> coordinates,
    Size size,
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
    return oldDelegate.areas != areas || oldDelegate.camera != camera || oldDelegate.animation != animation;
  }

  @override
  bool hitTest(Offset position) => true;
}

/// Data class for an area with animation properties
class AnimatedArea {
  final GeographicArea geoArea;
  final Color fillColor;
  final Color borderColor;
  final double fillOpacity;
  final double borderWidth;
  final ui.Shader? shader;
  final bool isDashed;
  final bool hasShadow;
  final Color? shadowColor;

  const AnimatedArea({
    required this.geoArea,
    required this.fillColor,
    required this.borderColor,
    this.fillOpacity = 0.3,
    this.borderWidth = 2.0,
    this.shader,
    this.isDashed = false,
    this.hasShadow = false,
    this.shadowColor,
  });

  AnimatedArea copyWith({
    GeographicArea? geoArea,
    Color? fillColor,
    Color? borderColor,
    double? fillOpacity,
    double? borderWidth,
    ui.Shader? shader,
    bool? isDashed,
    bool? hasShadow,
    Color? shadowColor,
  }) {
    return AnimatedArea(
      geoArea: geoArea ?? this.geoArea,
      fillColor: fillColor ?? this.fillColor,
      borderColor: borderColor ?? this.borderColor,
      fillOpacity: fillOpacity ?? this.fillOpacity,
      borderWidth: borderWidth ?? this.borderWidth,
      shader: shader ?? this.shader,
      isDashed: isDashed ?? this.isDashed,
      hasShadow: hasShadow ?? this.hasShadow,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AnimatedArea &&
        other.geoArea == geoArea &&
        other.fillColor == fillColor &&
        other.borderColor == borderColor &&
        other.fillOpacity == fillOpacity &&
        other.borderWidth == borderWidth &&
        other.shader == shader &&
        other.isDashed == isDashed &&
        other.hasShadow == hasShadow &&
        other.shadowColor == shadowColor;
  }

  @override
  int get hashCode {
    return Object.hash(
      geoArea,
      fillColor,
      borderColor,
      fillOpacity,
      borderWidth,
      shader,
      isDashed,
      hasShadow,
      shadowColor,
    );
  }
}
