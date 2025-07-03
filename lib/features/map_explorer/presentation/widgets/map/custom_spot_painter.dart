import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';

/// A custom painter for drawing spots (POIs) on the map with modern, beautiful styling
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
    // First pass: draw shadows for all spots
    for (final spot in spots) {
      final isSelected = spot.id == selectedSpot?.id;
      final spotVisitData = userSpotVisitData[spot.id];
      final isCheckedIn = spotVisitData?.isCheckedIn ?? false;

      if (isSelected || isCheckedIn) {
        _paintSpotShadow(canvas, spot, isSelected, isCheckedIn);
      }
    }

    // Second pass: draw all non-selected spots
    for (final spot in spots) {
      final isSelected = spot.id == selectedSpot?.id;
      if (!isSelected) {
        _paintSpot(canvas, spot, false);
      }
    }

    // Third pass: draw selected spot on top
    if (selectedSpot != null) {
      _paintSpot(canvas, selectedSpot!, true);
    }
  }

  void _paintSpotShadow(
    Canvas canvas,
    Spot spot,
    bool isSelected,
    bool isCheckedIn,
  ) {
    final screenPoint = camera.latLngToScreenOffset(spot.location);
    final size = isSelected ? 18.0 : (isCheckedIn ? 16.0 : 14.0);

    // Create shadow effect
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 4.0);

    canvas.drawCircle(
      screenPoint.translate(1, 2), // Slight offset for shadow
      size + 2,
      shadowPaint,
    );
  }

  void _paintSpot(Canvas canvas, Spot spot, bool isSelected) {
    final screenPoint = camera.latLngToScreenOffset(spot.location);
    final spotVisitData = userSpotVisitData[spot.id];
    final isVisited = spotVisitData != null && spotVisitData.visitCount > 0;
    final isCheckedIn = spotVisitData?.isCheckedIn ?? false;

    // Get colors and size based on category, selection state, visit status, and check-in status
    final colors = _getCategoryColors(spot.category, isVisited, isCheckedIn);
    final baseSize = isSelected ? 18.0 : (isCheckedIn ? 16.0 : 14.0);
    final borderWidth = isSelected ? 3.0 : 2.0;

    // Draw pulsing glow effect for checked-in spots
    if (isCheckedIn) {
      _drawPulsingGlow(canvas, screenPoint, baseSize + borderWidth + 6);
    }

    // Draw modern gradient background for outer ring
    final outerGradient = ui.Gradient.radial(
      screenPoint,
      baseSize + borderWidth,
      [
        Colors.white,
        Colors.grey.shade200,
      ],
      [0.0, 1.0],
    );

    canvas.drawCircle(
      screenPoint,
      baseSize + borderWidth,
      Paint()
        ..shader = outerGradient
        ..style = PaintingStyle.fill,
    );

    // Draw main circle with gradient
    final mainGradient = ui.Gradient.radial(
      screenPoint,
      baseSize,
      [
        colors.main.withValues(alpha: 0.9),
        colors.main,
      ],
      [0.0, 1.0],
    );

    canvas.drawCircle(
      screenPoint,
      baseSize,
      Paint()
        ..shader = mainGradient
        ..style = PaintingStyle.fill,
    );

    // Add inner highlight for modern effect
    final highlightGradient = ui.Gradient.radial(
      screenPoint.translate(-baseSize * 0.3, -baseSize * 0.3),
      baseSize * 0.6,
      [
        Colors.white.withValues(alpha: 0.4),
        Colors.transparent,
      ],
      [0.0, 1.0],
    );

    canvas.drawCircle(
      screenPoint,
      baseSize - 1,
      Paint()
        ..shader = highlightGradient
        ..style = PaintingStyle.fill,
    );

    // Draw enhanced icon
    _drawEnhancedCategoryIcon(
      canvas,
      screenPoint,
      spot.category,
      baseSize,
      colors.icon,
    );

    // Draw modern check-in indicator
    if (isCheckedIn) {
      _drawModernCheckInIndicator(canvas, screenPoint, baseSize + borderWidth);
    } else if (isVisited && !isSelected) {
      _drawModernVisitIndicator(canvas, screenPoint, baseSize + borderWidth);
    }

    // Draw modern selection indicator with animation effect
    if (isSelected) {
      _drawModernSelectionIndicator(
        canvas,
        screenPoint,
        baseSize + borderWidth,
      );
    }
  }

  void _drawPulsingGlow(Canvas canvas, Offset center, double radius) {
    // Create multiple glow layers for depth
    for (int i = 3; i >= 1; i--) {
      final glowPaint = Paint()
        ..color = Colors.orange.withValues(alpha: 0.1 * i)
        ..maskFilter = ui.MaskFilter.blur(ui.BlurStyle.normal, i * 2.0);

      canvas.drawCircle(center, radius + (i * 2), glowPaint);
    }
  }

  void _drawModernCheckInIndicator(
    Canvas canvas,
    Offset center,
    double outerRadius,
  ) {
    final indicatorSize = 8.0;
    final indicatorCenter = center.translate(
      outerRadius * 0.6,
      -outerRadius * 0.6,
    );

    // Draw modern gradient background
    final bgGradient = ui.Gradient.radial(
      indicatorCenter,
      indicatorSize + 2,
      [
        Colors.orange.shade400,
        Colors.orange.shade600,
      ],
      [0.0, 1.0],
    );

    // Outer glow
    canvas.drawCircle(
      indicatorCenter,
      indicatorSize + 3,
      Paint()
        ..color = Colors.orange.withValues(alpha: 0.3)
        ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 2.0),
    );

    // Main circle
    canvas.drawCircle(
      indicatorCenter,
      indicatorSize + 1,
      Paint()..shader = bgGradient,
    );

    // Draw modern star icon
    _drawModernStar(canvas, indicatorCenter, indicatorSize * 0.7, Colors.white);
  }

  void _drawModernVisitIndicator(
    Canvas canvas,
    Offset center,
    double outerRadius,
  ) {
    final indicatorSize = 6.0;
    final indicatorCenter = center.translate(
      outerRadius * 0.6,
      -outerRadius * 0.6,
    );

    // Green gradient background
    final bgGradient = ui.Gradient.radial(
      indicatorCenter,
      indicatorSize + 1,
      [
        Colors.green.shade400,
        Colors.green.shade600,
      ],
      [0.0, 1.0],
    );

    canvas.drawCircle(
      indicatorCenter,
      indicatorSize + 1,
      Paint()..shader = bgGradient,
    );

    // Draw modern checkmark
    _drawModernCheckmark(
      canvas,
      indicatorCenter,
      indicatorSize * 0.6,
      Colors.white,
    );
  }

  void _drawModernSelectionIndicator(
    Canvas canvas,
    Offset center,
    double outerRadius,
  ) {
    // Animated ring effect
    final ringPaint = Paint()
      ..color = Colors.blue.shade500
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // Outer selection ring
    canvas.drawCircle(center, outerRadius + 4, ringPaint);

    // Inner accent ring
    canvas.drawCircle(
      center,
      outerRadius + 2,
      Paint()
        ..color = Colors.blue.shade300.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
  }

  void _drawModernStar(Canvas canvas, Offset center, double size, Color color) {
    final path = ui.Path();
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Create a 5-pointed star
    for (int i = 0; i < 5; i++) {
      final angle1 = (i * 2 * math.pi) / 5 - math.pi / 2;
      final angle2 = ((i + 0.5) * 2 * math.pi) / 5 - math.pi / 2;

      final outerX = center.dx + size * math.cos(angle1);
      final outerY = center.dy + size * math.sin(angle1);
      final innerX = center.dx + (size * 0.4) * math.cos(angle2);
      final innerY = center.dy + (size * 0.4) * math.sin(angle2);

      if (i == 0) {
        path.moveTo(outerX, outerY);
      } else {
        path.lineTo(outerX, outerY);
      }
      path.lineTo(innerX, innerY);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  void _drawModernCheckmark(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = ui.Path()
      ..moveTo(center.dx - size * 0.5, center.dy)
      ..lineTo(center.dx - size * 0.1, center.dy + size * 0.4)
      ..lineTo(center.dx + size * 0.5, center.dy - size * 0.4);

    canvas.drawPath(path, paint);
  }

  void _drawEnhancedCategoryIcon(
    Canvas canvas,
    Offset center,
    String category,
    double spotSize,
    Color iconColor,
  ) {
    final iconSize = spotSize * 0.5;

    switch (category) {
      case 'restaurant':
        _drawEnhancedRestaurantIcon(canvas, center, iconSize, iconColor);
        break;
      case 'cafe':
        _drawEnhancedCafeIcon(canvas, center, iconSize, iconColor);
        break;
      case 'bar':
      case 'pub':
        _drawEnhancedBarIcon(canvas, center, iconSize, iconColor);
        break;
      case 'biergarten':
        _drawEnhancedBeerIcon(canvas, center, iconSize, iconColor);
        break;
      case 'viewpoint':
        _drawEnhancedViewpointIcon(canvas, center, iconSize, iconColor);
        break;
      case 'shop':
        _drawEnhancedShopIcon(canvas, center, iconSize, iconColor);
        break;
      default:
        _drawEnhancedDefaultIcon(canvas, center, iconSize, iconColor);
    }
  }

  void _drawEnhancedRestaurantIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Enhanced fork (left)
    final forkHandle = center.translate(-size * 0.25, 0);
    canvas.drawLine(
      forkHandle.translate(0, -size * 0.5),
      forkHandle.translate(0, size * 0.5),
      paint,
    );

    // Fork prongs
    for (int i = -1; i <= 1; i++) {
      canvas.drawLine(
        forkHandle.translate(i * size * 0.1, -size * 0.5),
        forkHandle.translate(i * size * 0.1, -size * 0.2),
        paint,
      );
    }

    // Enhanced knife (right)
    final knifeHandle = center.translate(size * 0.25, 0);
    canvas.drawLine(
      knifeHandle.translate(0, -size * 0.5),
      knifeHandle.translate(0, size * 0.5),
      paint,
    );

    // Knife blade
    final bladePath = ui.Path()
      ..moveTo(knifeHandle.dx - size * 0.1, knifeHandle.dy - size * 0.5)
      ..lineTo(knifeHandle.dx + size * 0.1, knifeHandle.dy - size * 0.3)
      ..lineTo(knifeHandle.dx, knifeHandle.dy - size * 0.2);

    canvas.drawPath(bladePath, paint);
  }

  void _drawEnhancedCafeIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    // Coffee cup body with rounded rectangle
    final cupRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: size * 0.8, height: size),
      Radius.circular(size * 0.1),
    );
    canvas.drawRRect(cupRect, paint);

    // Enhanced handle with better curve
    final handlePath = ui.Path()
      ..moveTo(center.dx + size * 0.4, center.dy - size * 0.3)
      ..cubicTo(
        center.dx + size * 0.7,
        center.dy - size * 0.2,
        center.dx + size * 0.7,
        center.dy + size * 0.2,
        center.dx + size * 0.4,
        center.dy + size * 0.3,
      );
    canvas.drawPath(handlePath, paint);

    // Steam lines
    final steamPaint = Paint()
      ..color = color.withValues(alpha: 0.6)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    for (int i = -1; i <= 1; i++) {
      final steamPath = ui.Path()
        ..moveTo(center.dx + i * size * 0.15, center.dy - size * 0.6)
        ..quadraticBezierTo(
          center.dx + i * size * 0.25,
          center.dy - size * 0.8,
          center.dx + i * size * 0.15,
          center.dy - size * 1.0,
        );
      canvas.drawPath(steamPath, steamPaint);
    }
  }

  void _drawEnhancedBarIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    // Martini glass shape
    final glassPath = ui.Path()
      ..moveTo(center.dx - size * 0.5, center.dy - size * 0.5)
      ..lineTo(center.dx + size * 0.5, center.dy - size * 0.5)
      ..lineTo(center.dx, center.dy + size * 0.1)
      ..close();

    canvas.drawPath(glassPath, paint);

    // Stem
    canvas.drawLine(
      center.translate(0, size * 0.1),
      center.translate(0, size * 0.5),
      paint,
    );

    // Base
    canvas.drawLine(
      center.translate(-size * 0.3, size * 0.5),
      center.translate(size * 0.3, size * 0.5),
      paint,
    );

    // Olive
    canvas.drawCircle(
      center.translate(0, -size * 0.2),
      size * 0.08,
      Paint()..color = color,
    );
  }

  void _drawEnhancedBeerIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    // Beer mug with rounded corners
    final mugRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: size * 0.7, height: size),
      Radius.circular(size * 0.05),
    );
    canvas.drawRRect(mugRect, paint);

    // Handle
    final handlePath = ui.Path()
      ..moveTo(center.dx + size * 0.35, center.dy - size * 0.2)
      ..cubicTo(
        center.dx + size * 0.6,
        center.dy - size * 0.15,
        center.dx + size * 0.6,
        center.dy + size * 0.15,
        center.dx + size * 0.35,
        center.dy + size * 0.2,
      );
    canvas.drawPath(handlePath, paint);

    // Foam
    final foamPaint = Paint()
      ..color = color.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;

    canvas.drawOval(
      Rect.fromCenter(
        center: center.translate(0, -size * 0.35),
        width: size * 0.6,
        height: size * 0.2,
      ),
      foamPaint,
    );
  }

  void _drawEnhancedViewpointIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    // Eye outline with better proportions
    final eyePath = ui.Path()
      ..moveTo(center.dx - size * 0.5, center.dy)
      ..cubicTo(
        center.dx - size * 0.3,
        center.dy - size * 0.4,
        center.dx + size * 0.3,
        center.dy - size * 0.4,
        center.dx + size * 0.5,
        center.dy,
      )
      ..cubicTo(
        center.dx + size * 0.3,
        center.dy + size * 0.4,
        center.dx - size * 0.3,
        center.dy + size * 0.4,
        center.dx - size * 0.5,
        center.dy,
      );

    canvas.drawPath(eyePath, paint);

    // Iris
    canvas.drawCircle(
      center,
      size * 0.25,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );

    // Pupil
    canvas.drawCircle(
      center,
      size * 0.12,
      Paint()..color = color,
    );

    // Highlight
    canvas.drawCircle(
      center.translate(-size * 0.05, -size * 0.05),
      size * 0.04,
      Paint()..color = color.withValues(alpha: 0.8),
    );
  }

  void _drawEnhancedShopIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    // Shopping bag body
    final bagRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center.translate(0, size * 0.1),
        width: size * 0.8,
        height: size * 0.8,
      ),
      Radius.circular(size * 0.05),
    );
    canvas.drawRRect(bagRect, paint);

    // Handles with better curves
    final handlePath = ui.Path()
      ..moveTo(center.dx - size * 0.25, center.dy - size * 0.2)
      ..cubicTo(
        center.dx - size * 0.15,
        center.dy - size * 0.5,
        center.dx + size * 0.15,
        center.dy - size * 0.5,
        center.dx + size * 0.25,
        center.dy - size * 0.2,
      );
    canvas.drawPath(handlePath, paint);

    // Shopping tag/label
    canvas.drawOval(
      Rect.fromCenter(
        center: center.translate(size * 0.2, -size * 0.1),
        width: size * 0.3,
        height: size * 0.2,
      ),
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  void _drawEnhancedDefaultIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    // Modern location pin style
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final pinPath = ui.Path()
      ..moveTo(center.dx, center.dy - size * 0.5)
      ..lineTo(center.dx + size * 0.3, center.dy + size * 0.2)
      ..lineTo(center.dx, center.dy + size * 0.5)
      ..lineTo(center.dx - size * 0.3, center.dy + size * 0.2)
      ..close();

    canvas.drawPath(pinPath, paint);

    // Inner dot
    canvas.drawCircle(
      center.translate(0, -size * 0.1),
      size * 0.15,
      Paint()..color = Colors.white,
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
