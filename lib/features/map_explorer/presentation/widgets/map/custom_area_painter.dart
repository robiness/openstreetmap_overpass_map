import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';

/// A custom painter for drawing geographic areas with modern, beautiful styling
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

    // First pass: draw shadows for areas with data
    for (final area in areas) {
      final areaVisitData = userVisitData[area.id];
      if (areaVisitData != null &&
          (areaVisitData.status == AreaExplorationStatus.completed ||
              areaVisitData.status == AreaExplorationStatus.partial)) {
        _paintAreaShadow(canvas, size, area);
      }
    }

    // Second pass: draw all non-selected areas
    for (final area in areas) {
      final isSelected = area.id == selectedArea?.id;
      if (!isSelected) {
        _paintArea(canvas, size, area, false);
      }
    }

    // Third pass: draw selected area on top with special effects
    if (selectedArea != null) {
      _paintArea(canvas, size, selectedArea!, true);
    }
  }

  void _paintAreaShadow(Canvas canvas, Size size, GeographicArea area) {
    for (final coordinateRing in area.coordinates) {
      final path = _createPathFromCoordinates(coordinateRing);
      if (path != null) {
        // Subtle shadow effect
        final shadowPaint = Paint()
          ..color = Colors.black.withValues(alpha: 0.1)
          ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 3.0);

        canvas.drawPath(path, shadowPaint);
      }
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

        // Draw the gradient fill
        if (colors.fillGradient != null) {
          canvas.drawPath(path, Paint()..shader = colors.fillGradient);
        } else if (colors.fill != Colors.transparent) {
          canvas.drawPath(
            path,
            Paint()
              ..color = colors.fill
              ..style = PaintingStyle.fill,
          );
        }

        // Draw inner highlight for depth
        if (colors.highlightGradient != null && !isSelected) {
          canvas.drawPath(
            path,
            Paint()
              ..shader = colors.highlightGradient
              ..style = PaintingStyle.fill,
          );
        }

        // Draw the border with modern styling
        final borderPaint = Paint()
          ..color = colors.border
          ..style = PaintingStyle.stroke
          ..strokeWidth = colors.strokeWidth
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round;

        // Add gradient to border if available
        if (colors.borderGradient != null) {
          borderPaint.shader = colors.borderGradient;
        }

        canvas.drawPath(path, borderPaint);

        // Draw special selection effects
        if (isSelected) {
          _drawSelectionEffects(canvas, path, colors);
        }
      }
    }
  }

  void _drawSelectionEffects(Canvas canvas, ui.Path path, _AreaColors colors) {
    // Animated glow effect for selected area
    for (int i = 3; i >= 1; i--) {
      final glowPaint = Paint()
        ..color = Colors.blue.withValues(alpha: 0.05 * i)
        ..style = PaintingStyle.stroke
        ..strokeWidth = colors.strokeWidth + (i * 2.0)
        ..strokeJoin = StrokeJoin.round
        ..maskFilter = ui.MaskFilter.blur(ui.BlurStyle.normal, i * 1.5);

      canvas.drawPath(path, glowPaint);
    }

    // Outer selection ring
    final selectionPaint = Paint()
      ..color = Colors.blue.shade400.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, selectionPaint);
  }

  /// Gets appropriate colors based on area exploration status with modern gradients
  _AreaColors _getAreaColors(UserAreaData? areaData, bool isSelected) {
    if (isSelected) {
      return _AreaColors(
        fill: Colors.blue.withValues(alpha: 0.15),
        border: Colors.blue.shade600,
        strokeWidth: 4.0,
        fillGradient: ui.Gradient.linear(
          const Offset(0, 0),
          const Offset(100, 100),
          [
            Colors.blue.withValues(alpha: 0.2),
            Colors.blue.withValues(alpha: 0.1),
          ],
          [0.0, 1.0],
        ),
        borderGradient: ui.Gradient.linear(
          const Offset(0, 0),
          const Offset(100, 100),
          [
            Colors.blue.shade500,
            Colors.blue.shade700,
          ],
          [0.0, 1.0],
        ),
      );
    }

    if (areaData == null) {
      // No data available - subtle neutral appearance
      return _AreaColors(
        fill: Colors.grey.withValues(alpha: 0.03),
        border: Colors.grey.withValues(alpha: 0.3),
        strokeWidth: 1.0,
        fillGradient: ui.Gradient.linear(
          const Offset(0, 0),
          const Offset(50, 50),
          [
            Colors.grey.withValues(alpha: 0.05),
            Colors.grey.withValues(alpha: 0.02),
          ],
          [0.0, 1.0],
        ),
      );
    }

    // Enhanced colors with gradients for different states
    switch (areaData.status) {
      case AreaExplorationStatus.noSpots:
      case AreaExplorationStatus.unvisited:
        return _AreaColors(
          fill: Colors.grey.withValues(alpha: 0.08),
          border: Colors.grey.shade400,
          strokeWidth: 1.5,
          fillGradient: ui.Gradient.radial(
            const Offset(50, 50),
            50,
            [
              Colors.grey.withValues(alpha: 0.1),
              Colors.grey.withValues(alpha: 0.05),
            ],
            [0.0, 1.0],
          ),
          highlightGradient: ui.Gradient.linear(
            const Offset(0, 0),
            const Offset(30, 30),
            [
              Colors.white.withValues(alpha: 0.1),
              Colors.transparent,
            ],
            [0.0, 1.0],
          ),
        );

      case AreaExplorationStatus.partial:
        return _AreaColors(
          fill: Colors.orange.withValues(alpha: 0.15),
          border: Colors.orange.shade600,
          strokeWidth: 2.5,
          fillGradient: ui.Gradient.radial(
            const Offset(50, 50),
            60,
            [
              Colors.orange.withValues(alpha: 0.2),
              Colors.orange.withValues(alpha: 0.1),
              Colors.orange.withValues(alpha: 0.05),
            ],
            [0.0, 0.5, 1.0],
          ),
          borderGradient: ui.Gradient.linear(
            const Offset(0, 0),
            const Offset(100, 100),
            [
              Colors.orange.shade500,
              Colors.orange.shade700,
            ],
            [0.0, 1.0],
          ),
          highlightGradient: ui.Gradient.linear(
            const Offset(0, 0),
            const Offset(40, 40),
            [
              Colors.yellow.withValues(alpha: 0.15),
              Colors.transparent,
            ],
            [0.0, 1.0],
          ),
        );

      case AreaExplorationStatus.completed:
        return _AreaColors(
          fill: Colors.green.withValues(alpha: 0.18),
          border: Colors.green.shade600,
          strokeWidth: 3.0,
          fillGradient: ui.Gradient.radial(
            const Offset(50, 50),
            70,
            [
              Colors.green.withValues(alpha: 0.25),
              Colors.green.withValues(alpha: 0.15),
              Colors.green.withValues(alpha: 0.08),
            ],
            [0.0, 0.6, 1.0],
          ),
          borderGradient: ui.Gradient.linear(
            const Offset(0, 0),
            const Offset(100, 100),
            [
              Colors.green.shade500,
              Colors.green.shade700,
            ],
            [0.0, 1.0],
          ),
          highlightGradient: ui.Gradient.linear(
            const Offset(0, 0),
            const Offset(50, 50),
            [
              Colors.lightGreen.withValues(alpha: 0.2),
              Colors.transparent,
            ],
            [0.0, 1.0],
          ),
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

/// Enhanced helper class for area colors with gradient support
class _AreaColors {
  final Color fill;
  final Color border;
  final double strokeWidth;
  final ui.Shader? fillGradient;
  final ui.Shader? borderGradient;
  final ui.Shader? highlightGradient;

  _AreaColors({
    required this.fill,
    required this.border,
    required this.strokeWidth,
    this.fillGradient,
    this.borderGradient,
    this.highlightGradient,
  });
}
