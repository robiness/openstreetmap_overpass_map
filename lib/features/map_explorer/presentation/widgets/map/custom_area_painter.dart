import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/app/theme/app_theme_data.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';

/// A custom painter for drawing geographic areas with modern, beautiful styling
class CustomAreaPainter extends CustomPainter {
  final List<GeographicArea> areas;
  final MapCamera camera;
  final AppThemeData theme;
  final GeographicArea? selectedArea;
  final Map<String, UserAreaData> userVisitData;

  CustomAreaPainter({
    required this.areas,
    required this.camera,
    required this.theme,
    this.selectedArea,
    this.userVisitData = const {},
  });

  @override
  void paint(Canvas canvas, Size size) {
    // First pass: draw shadows for areas with data
    for (final area in areas) {
      final areaVisitData = userVisitData[area.id.toString()];
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
          ..color = theme.shadow.withAlpha((255 * 0.1).round())
          ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 3.0);

        canvas.drawPath(path, shadowPaint);
      }
    }
  }

  ui.Path? _createPathFromCoordinates(List<List<double>> coordinateRing) {
    if (coordinateRing.length < 3) return null;

    final List<Offset> offsets = [];
    final mapOrigin = camera.pixelOrigin;

    for (final point in coordinateRing) {
      final latLng = LatLng(point[1], point[0]);
      final projectedPoint = camera.crs.latLngToOffset(latLng, camera.zoom);
      final screenPoint = projectedPoint - mapOrigin;
      offsets.add(Offset(screenPoint.dx, screenPoint.dy));
    }

    if (offsets.isEmpty) return null;

    final path = ui.Path();
    path.moveTo(offsets.first.dx, offsets.first.dy);
    for (int i = 1; i < offsets.length; i++) {
      path.lineTo(offsets[i].dx, offsets[i].dy);
    }
    path.close();
    return path;
  }

  void _paintArea(
    Canvas canvas,
    Size size,
    GeographicArea area,
    bool isSelected,
  ) {
    final areaVisitData = userVisitData[area.id.toString()];

    // Convert coordinates to screen points and draw
    for (final coordinateRing in area.coordinates) {
      final path = _createPathFromCoordinates(coordinateRing);

      if (path != null) {
        // Determine colors based on exploration status
        final colors = _getAreaColors(areaVisitData, isSelected);

        // Draw the fill
        if (areaVisitData?.status == AreaExplorationStatus.partial) {
          final gradient = ui.Gradient.linear(
            path.getBounds().centerLeft,
            path.getBounds().centerRight,
            [
              theme.mapStyles.completedFill,
              theme.mapStyles.inProgressFill,
            ],
            [
              areaVisitData!.completionPercentage,
              areaVisitData.completionPercentage,
            ],
          );
          canvas.drawPath(path, Paint()..shader = gradient);
        } else if (colors.fill != Colors.transparent) {
          canvas.drawPath(
            path,
            Paint()
              ..color = colors.fill
              ..style = PaintingStyle.fill,
          );
        }

        // Draw inner highlight for depth
        // if (colors.highlightGradient != null && !isSelected) {
        //   canvas.drawPath(
        //     path,
        //     Paint()
        //       ..shader = colors.highlightGradient
        //       ..style = PaintingStyle.fill,
        //   );
        // }

        // Draw the border with modern styling
        final borderPaint = Paint()
          ..color = colors.border
          ..style = PaintingStyle.stroke
          ..strokeWidth = colors.strokeWidth
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round;

        // Add gradient to border if available
        // if (colors.borderGradient != null) {
        //   borderPaint.shader = colors.borderGradient;
        // }

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
        ..color = theme.navigation.withAlpha((255 * 0.05 * i).round())
        ..style = PaintingStyle.stroke
        ..strokeWidth = theme.mapStyles.selectedBorderWidth + (i * 2.0)
        ..strokeJoin = StrokeJoin.round
        ..maskFilter = ui.MaskFilter.blur(ui.BlurStyle.normal, i * 1.5);

      canvas.drawPath(path, glowPaint);
    }

    // Outer selection ring
    final selectionPaint = Paint()
      ..color = theme.navigation.withAlpha((255 * 0.8).round())
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, selectionPaint);
  }

  /// Gets appropriate colors based on area exploration status using semantic theme data
  _AreaColors _getAreaColors(UserAreaData? areaData, bool isSelected) {
    final styles = theme.mapStyles;

    if (isSelected) {
      return _AreaColors(
        fill: styles.selectedFill,
        border: styles.selectedBorder,
        strokeWidth: styles.selectedBorderWidth,
      );
    }

    if (areaData == null) {
      // Default state: unvisited
      return _AreaColors(
        fill: styles.unvisitedFill,
        border: styles.unvisitedBorder,
        strokeWidth: styles.unvisitedBorderWidth,
      );
    }

    switch (areaData.status) {
      case AreaExplorationStatus.noSpots:
      case AreaExplorationStatus.unvisited:
        return _AreaColors(
          fill: styles.unvisitedFill,
          border: styles.unvisitedBorder,
          strokeWidth: styles.unvisitedBorderWidth,
        );

      case AreaExplorationStatus.partial:
        return _AreaColors(
          fill: Colors.transparent, // Handled specially in _paintArea
          border: styles.inProgressBorder,
          strokeWidth: styles.inProgressBorderWidth,
        );

      case AreaExplorationStatus.completed:
        return _AreaColors(
          fill: styles.completedFill,
          border: styles.completedBorder,
          strokeWidth: styles.completedBorderWidth,
        );
    }
  }

  @override
  bool shouldRepaint(CustomAreaPainter oldDelegate) {
    return oldDelegate.areas != areas ||
        oldDelegate.camera.zoom != camera.zoom ||
        oldDelegate.camera.rotationRad != camera.rotationRad ||
        oldDelegate.camera.center != camera.center ||
        oldDelegate.selectedArea != selectedArea ||
        oldDelegate.userVisitData != userVisitData ||
        oldDelegate.theme != theme;
  }

  @override
  bool hitTest(Offset position) => false;
}

/// Helper class to bundle paint properties for an area
class _AreaColors {
  final Color fill;
  final Color border;
  final double strokeWidth;
  // Gradients are now handled directly in the painter for simplicity
  // final ui.Gradient? fillGradient;
  // final ui.Gradient? borderGradient;
  // final ui.Gradient? highlightGradient;

  _AreaColors({
    required this.fill,
    required this.border,
    required this.strokeWidth,
    // this.fillGradient,
    // this.borderGradient,
    // this.highlightGradient,
  });
}
