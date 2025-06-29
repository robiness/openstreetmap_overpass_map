import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';

/// A custom painter for drawing spots (POIs) on the map
class CustomSpotPainter extends CustomPainter {
  final List<Spot> spots;
  final MapCamera camera;
  final Spot? selectedSpot;
  final Map<int, UserSpotData> userSpotVisitData;

  CustomSpotPainter({
    required this.spots,
    required this.camera,
    this.selectedSpot,
    this.userSpotVisitData = const {},
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
    final spotVisitData = userSpotVisitData[spot.id];
    final isVisited = spotVisitData != null && spotVisitData.visitCount > 0;
    final isCheckedIn = spotVisitData?.isCheckedIn ?? false;

    // Get colors and size based on category, selection state, visit status, and check-in status
    final colors = _getCategoryColors(spot.category, isVisited, isCheckedIn);
    final size = isSelected ? 16.0 : (isCheckedIn ? 14.0 : 12.0);
    final borderWidth = isSelected ? 3.0 : (isCheckedIn ? 3.0 : 2.0);

    // Draw special glow effect for checked-in spots
    if (isCheckedIn) {
      canvas.drawCircle(
        screenPoint,
        size + borderWidth + 4,
        Paint()
          ..color = Colors.orange.withValues(alpha: 0.3)
          ..style = PaintingStyle.fill,
      );
    }

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

    // Draw check-in indicator for checked-in spots
    if (isCheckedIn) {
      _drawCheckInIndicator(canvas, screenPoint, size + borderWidth);
    } else if (isVisited && !isSelected) {
      // Draw visit indicator for visited spots (only if not checked in)
      _drawVisitIndicator(canvas, screenPoint, size + borderWidth);
    }

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

  void _drawCheckInIndicator(Canvas canvas, Offset center, double outerRadius) {
    // Draw a bright star or diamond to indicate checked-in status
    final indicatorSize = 6.0;
    final indicatorCenter = center.translate(
      outerRadius * 0.7,
      -outerRadius * 0.7,
    );

    // Draw bright circle background
    canvas.drawCircle(
      indicatorCenter,
      indicatorSize + 1,
      Paint()
        ..color = Colors.orange
        ..style = PaintingStyle.fill,
    );

    // Draw a star or diamond shape
    final starPath = ui.Path();
    final starSize = indicatorSize * 0.8;

    // Create a diamond/star shape
    starPath.moveTo(indicatorCenter.dx, indicatorCenter.dy - starSize);
    starPath.lineTo(indicatorCenter.dx + starSize * 0.5, indicatorCenter.dy);
    starPath.lineTo(indicatorCenter.dx, indicatorCenter.dy + starSize);
    starPath.lineTo(indicatorCenter.dx - starSize * 0.5, indicatorCenter.dy);
    starPath.close();

    canvas.drawPath(
      starPath,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );
  }

  void _drawVisitIndicator(Canvas canvas, Offset center, double outerRadius) {
    // Draw a small checkmark to indicate visited status
    final checkPath = ui.Path();
    final checkSize = 4.0;
    final checkCenter = center.translate(outerRadius * 0.6, -outerRadius * 0.6);

    // Draw small circle background for checkmark
    canvas.drawCircle(
      checkCenter,
      checkSize + 1,
      Paint()
        ..color = Colors.green
        ..style = PaintingStyle.fill,
    );

    // Draw checkmark
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    checkPath.moveTo(checkCenter.dx - checkSize * 0.5, checkCenter.dy);
    checkPath.lineTo(
      checkCenter.dx - checkSize * 0.1,
      checkCenter.dy + checkSize * 0.3,
    );
    checkPath.lineTo(
      checkCenter.dx + checkSize * 0.5,
      checkCenter.dy - checkSize * 0.3,
    );

    canvas.drawPath(checkPath, paint);
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

  SpotColors _getCategoryColors(
    String category,
    bool isVisited,
    bool isCheckedIn,
  ) {
    final baseColors = _getBaseCategoryColors(category);

    if (isCheckedIn) {
      // Bright, vibrant colors for checked-in spots
      return SpotColors(
        Colors.orange,
        Colors.white,
      );
    } else if (isVisited) {
      // Darken colors for visited spots
      return SpotColors(
        baseColors.main.withValues(alpha: 0.8),
        baseColors.icon,
      );
    }

    return baseColors;
  }

  SpotColors _getBaseCategoryColors(String category) {
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
    return oldDelegate.spots != spots ||
        oldDelegate.camera != camera ||
        oldDelegate.selectedSpot != selectedSpot ||
        oldDelegate.userSpotVisitData != userSpotVisitData;
  }

  @override
  bool hitTest(Offset position) {
    // Test spots in reverse order (same as painting order - selected spot is painted last)
    final spotsToTest = <Spot>[];
    final nonSelectedSpots = <Spot>[];

    // Separate selected and non-selected spots
    for (final spot in spots) {
      final isSelected = spot.id == selectedSpot?.id;
      if (isSelected) {
        spotsToTest.add(spot); // Selected spot will be tested last
      } else {
        nonSelectedSpots.add(spot);
      }
    }

    // Test non-selected spots first, then selected spot (matching paint order)
    for (final spot in nonSelectedSpots) {
      if (_testSpotHit(position, spot, false)) {
        return true;
      }
    }

    // Test selected spot last (it's painted on top)
    for (final spot in spotsToTest) {
      if (_testSpotHit(position, spot, true)) {
        return true;
      }
    }

    return false;
  }

  bool _testSpotHit(Offset position, Spot spot, bool isSelected) {
    final screenPoint = camera.latLngToScreenOffset(spot.location);
    final spotSize = isSelected ? 16.0 : 12.0;
    final borderWidth = isSelected ? 3.0 : 2.0;

    // Test selection indicator first (outermost ring)
    if (isSelected) {
      final selectionRadius = spotSize + borderWidth + 2;
      if (_isPointInCircle(
        position,
        screenPoint,
        selectionRadius,
        selectionRadius - 2,
      )) {
        return true; // Hit the selection ring
      }
    }

    // Test main circle with white border
    final totalRadius = spotSize + borderWidth;
    if (_isPointInCircle(position, screenPoint, totalRadius)) {
      return true; // Hit the main circle (including border)
    }

    return false;
  }

  bool _isPointInCircle(
    Offset point,
    Offset center,
    double radius, [
    double? innerRadius,
  ]) {
    final dx = point.dx - center.dx;
    final dy = point.dy - center.dy;
    final distanceSquared = dx * dx + dy * dy;
    final radiusSquared = radius * radius;

    // If innerRadius is specified, test for ring (between inner and outer radius)
    if (innerRadius != null) {
      final innerRadiusSquared = innerRadius * innerRadius;
      return distanceSquared <= radiusSquared &&
          distanceSquared >= innerRadiusSquared;
    }

    // Otherwise test for filled circle
    return distanceSquared <= radiusSquared;
  }
}

class SpotColors {
  final Color main;
  final Color icon;

  SpotColors(this.main, this.icon);
}
