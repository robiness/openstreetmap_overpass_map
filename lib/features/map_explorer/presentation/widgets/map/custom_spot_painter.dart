import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';

/// A custom painter for drawing spots (POIs) on the map
class CustomSpotPainter extends CustomPainter {
  final List<Spot> spots;
  final MapCamera camera;
  final Spot? selectedSpot;

  CustomSpotPainter({
    required this.spots,
    required this.camera,
    this.selectedSpot,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // First pass: draw all non-selected spots
    for (final spot in spots) {
      final isSelected = spot.id == selectedSpot?.id;
      if (!isSelected) {
        _paintSpot(canvas, spot, false);
      }
    }

    // Second pass: draw selected spot on top
    if (selectedSpot != null) {
      _paintSpot(canvas, selectedSpot!, true);
    }
  }

  void _paintSpot(Canvas canvas, Spot spot, bool isSelected) {
    final screenPoint = camera.latLngToScreenOffset(spot.location);

    // Get colors and size based on category and selection state
    final colors = _getCategoryColors(spot.category);
    final size = isSelected ? 16.0 : 12.0;
    final borderWidth = isSelected ? 3.0 : 2.0;

    // Draw outer border (white outline)
    canvas.drawCircle(
      screenPoint,
      size + borderWidth,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );

    // Draw main circle with category color
    canvas.drawCircle(
      screenPoint,
      size,
      Paint()
        ..color = colors.main
        ..style = PaintingStyle.fill,
    );

    // Draw icon or symbol for the category
    _drawCategoryIcon(canvas, screenPoint, spot.category, size, colors.icon);

    // Draw selection indicator
    if (isSelected) {
      canvas.drawCircle(
        screenPoint,
        size + borderWidth + 2,
        Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0,
      );
    }
  }

  void _drawCategoryIcon(
    Canvas canvas,
    Offset center,
    String category,
    double spotSize,
    Color iconColor,
  ) {
    final iconSize = spotSize * 0.6;

    switch (category) {
      case 'restaurant':
        _drawRestaurantIcon(canvas, center, iconSize, iconColor);
        break;
      case 'cafe':
        _drawCafeIcon(canvas, center, iconSize, iconColor);
        break;
      case 'bar':
      case 'pub':
        _drawBarIcon(canvas, center, iconSize, iconColor);
        break;
      case 'biergarten':
        _drawBeerIcon(canvas, center, iconSize, iconColor);
        break;
      case 'viewpoint':
        _drawViewpointIcon(canvas, center, iconSize, iconColor);
        break;
      case 'shop':
        _drawShopIcon(canvas, center, iconSize, iconColor);
        break;
      default:
        _drawDefaultIcon(canvas, center, iconSize, iconColor);
    }
  }

  void _drawRestaurantIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    // Simple fork and knife representation
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    // Fork (left side)
    final forkStart = center.translate(-size * 0.3, -size * 0.4);
    final forkEnd = center.translate(-size * 0.3, size * 0.4);
    canvas.drawLine(forkStart, forkEnd, paint);

    // Knife (right side)
    final knifeStart = center.translate(size * 0.3, -size * 0.4);
    final knifeEnd = center.translate(size * 0.3, size * 0.4);
    canvas.drawLine(knifeStart, knifeEnd, paint);
  }

  void _drawCafeIcon(Canvas canvas, Offset center, double size, Color color) {
    // Simple coffee cup representation
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final cupRect = Rect.fromCenter(
      center: center,
      width: size,
      height: size * 0.8,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(cupRect, const Radius.circular(2)),
      paint,
    );

    // Handle
    final handlePath = ui.Path()
      ..moveTo(center.dx + size * 0.5, center.dy - size * 0.2)
      ..quadraticBezierTo(
        center.dx + size * 0.7,
        center.dy,
        center.dx + size * 0.5,
        center.dy + size * 0.2,
      );
    canvas.drawPath(handlePath, paint);
  }

  void _drawBarIcon(Canvas canvas, Offset center, double size, Color color) {
    // Simple glass representation
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final glassPath = ui.Path()
      ..moveTo(center.dx - size * 0.4, center.dy - size * 0.4)
      ..lineTo(center.dx - size * 0.3, center.dy + size * 0.4)
      ..lineTo(center.dx + size * 0.3, center.dy + size * 0.4)
      ..lineTo(center.dx + size * 0.4, center.dy - size * 0.4)
      ..close();

    canvas.drawPath(glassPath, paint);
  }

  void _drawBeerIcon(Canvas canvas, Offset center, double size, Color color) {
    // Beer mug representation
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final mugRect = Rect.fromCenter(
      center: center,
      width: size * 0.7,
      height: size,
    );
    canvas.drawRect(mugRect, paint);

    // Handle
    final handleRect = Rect.fromLTWH(
      center.dx + size * 0.35,
      center.dy - size * 0.2,
      size * 0.2,
      size * 0.4,
    );
    canvas.drawOval(handleRect, paint);
  }

  void _drawViewpointIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    // Eye/viewpoint representation
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Eye shape
    final eyePath = ui.Path()
      ..moveTo(center.dx - size * 0.4, center.dy)
      ..quadraticBezierTo(
        center.dx,
        center.dy - size * 0.3,
        center.dx + size * 0.4,
        center.dy,
      )
      ..quadraticBezierTo(
        center.dx,
        center.dy + size * 0.3,
        center.dx - size * 0.4,
        center.dy,
      );
    canvas.drawPath(eyePath, paint);

    // Pupil
    canvas.drawCircle(center, size * 0.15, Paint()..color = color);
  }

  void _drawShopIcon(Canvas canvas, Offset center, double size, Color color) {
    // Shopping bag representation
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final bagRect = Rect.fromCenter(
      center: center.translate(0, size * 0.1),
      width: size * 0.8,
      height: size * 0.7,
    );
    canvas.drawRect(bagRect, paint);

    // Handles
    final handlePath = ui.Path()
      ..moveTo(center.dx - size * 0.2, center.dy - size * 0.4)
      ..quadraticBezierTo(
        center.dx,
        center.dy - size * 0.6,
        center.dx + size * 0.2,
        center.dy - size * 0.4,
      );
    canvas.drawPath(handlePath, paint);
  }

  void _drawDefaultIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    // Simple circle for unknown categories
    canvas.drawCircle(
      center,
      size * 0.3,
      Paint()..color = color,
    );
  }

  SpotColors _getCategoryColors(String category) {
    switch (category) {
      case 'restaurant':
        return SpotColors(Colors.red.shade600, Colors.white);
      case 'cafe':
        return SpotColors(Colors.brown.shade600, Colors.white);
      case 'bar':
      case 'pub':
        return SpotColors(Colors.purple.shade600, Colors.white);
      case 'biergarten':
        return SpotColors(Colors.amber.shade600, Colors.white);
      case 'viewpoint':
        return SpotColors(Colors.green.shade600, Colors.white);
      case 'shop':
        return SpotColors(Colors.blue.shade600, Colors.white);
      default:
        return SpotColors(Colors.grey.shade600, Colors.white);
    }
  }

  @override
  bool shouldRepaint(CustomSpotPainter oldDelegate) {
    return oldDelegate.spots != spots || oldDelegate.camera != camera || oldDelegate.selectedSpot != selectedSpot;
  }

  @override
  bool hitTest(Offset position) => false;
}

class SpotColors {
  final Color main;
  final Color icon;

  SpotColors(this.main, this.icon);
}
