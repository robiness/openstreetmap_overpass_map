import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:overpass_map/app/theme/app_theme.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';

/// A custom painter for drawing spots (POIs) on the map with modern, beautiful styling
class CustomSpotPainter extends CustomPainter {
  final List<Spot> spots;
  final MapCamera camera;
  final Spot? selectedSpot;
  final Map<String, UserSpotData> userSpotVisitData;
  final AppThemeData theme;

  CustomSpotPainter({
    required this.spots,
    required this.camera,
    required this.theme,
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
        ..color = theme.currentState.withValues(alpha: 0.1 * i)
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

    // Draw modern gradient background using theme colors
    final bgGradient = ui.Gradient.radial(
      indicatorCenter,
      indicatorSize + 2,
      [
        theme.currentState.withValues(alpha: 0.8),
        theme.currentState,
      ],
      [0.0, 1.0],
    );

    // Outer glow
    canvas.drawCircle(
      indicatorCenter,
      indicatorSize + 3,
      Paint()
        ..color = theme.currentState.withValues(alpha: 0.3)
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

    // Progress gradient background using theme colors
    final bgGradient = ui.Gradient.radial(
      indicatorCenter,
      indicatorSize + 1,
      [
        theme.progress.withValues(alpha: 0.8),
        theme.progress,
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
    // Animated ring effect using theme navigation color
    final ringPaint = Paint()
      ..color = theme.navigation
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // Outer selection ring
    canvas.drawCircle(center, outerRadius + 4, ringPaint);

    // Inner accent ring
    canvas.drawCircle(
      center,
      outerRadius + 2,
      Paint()
        ..color = theme.navigation.withValues(alpha: 0.5)
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
    // Choose icon based on actual database categories
    switch (category.toLowerCase()) {
      case 'kultur & geschichte':
        _drawEnhancedKulturIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'genuss & kulinarik':
        _drawEnhancedRestaurantIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'architektur & besonderes':
        _drawEnhancedArchitekturIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'architektur & geschichte':
        _drawEnhancedGeschichteIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'natur & ausblick':
        _drawEnhancedViewpointIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'natur & geschichte':
        _drawEnhancedNaturIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      // Legacy categories (for backward compatibility)
      case 'restaurant':
        _drawEnhancedRestaurantIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'cafe':
        _drawEnhancedCafeIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'bar':
      case 'pub':
        _drawEnhancedBarIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'biergarten':
        _drawEnhancedBiergartenIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'viewpoint':
      case 'aussichtspunkt':
        _drawEnhancedViewpointIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'shop':
        _drawEnhancedShopIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'kultur':
        _drawEnhancedKulturIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'natur':
        _drawEnhancedNaturIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'erholung':
        _drawEnhancedErholungIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'geschichte':
        _drawEnhancedGeschichteIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'architektur':
        _drawEnhancedArchitekturIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'sport':
        _drawEnhancedSportIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'bildung':
        _drawEnhancedBildungIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      case 'soziales':
      case 'gemeinschaft':
        _drawEnhancedSozialesIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
      default:
        _drawEnhancedDefaultIcon(canvas, center, spotSize * 0.5, iconColor);
        break;
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

    // Draw modern star icon in the center of the glass
    _drawModernStar(canvas, center, size * 0.3, color.withValues(alpha: 0.6));
  }

  void _drawEnhancedBiergartenIcon(
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

    // Draw modern star icon in the center of the mug
    _drawModernStar(canvas, center, size * 0.3, color.withValues(alpha: 0.6));
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

    // Telescope body
    canvas.drawCircle(center, size * 0.4, paint);

    // Eyepiece
    final eyePiecePath = ui.Path()
      ..moveTo(center.dx - size * 0.3, center.dy - size * 0.3)
      ..lineTo(center.dx - size * 0.6, center.dy - size * 0.6);
    canvas.drawPath(eyePiecePath, paint);

    // Stand
    final standPath = ui.Path()
      ..moveTo(center.dx, center.dy + size * 0.4)
      ..lineTo(center.dx - size * 0.2, center.dy + size * 0.8)
      ..moveTo(center.dx, center.dy + size * 0.4)
      ..lineTo(center.dx + size * 0.2, center.dy + size * 0.8);
    canvas.drawPath(standPath, paint);
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

  void _drawEnhancedKulturIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw happy mask
    final happyPath = ui.Path()
      ..addOval(
        Rect.fromCenter(
          center: center.translate(-size * 0.4, 0),
          width: size,
          height: size * 1.2,
        ),
      )
      ..moveTo(center.dx - size * 0.7, center.dy)
      ..quadraticBezierTo(
        center.dx - size * 0.4,
        center.dy + size * 0.5,
        center.dx,
        center.dy,
      );
    canvas.drawPath(happyPath, paint);
    canvas.drawCircle(
      center.translate(-size * 0.4, -size * 0.2),
      size * 0.1,
      paint..style = PaintingStyle.fill,
    );

    // Draw sad mask
    final sadPath = ui.Path()
      ..addOval(
        Rect.fromCenter(
          center: center.translate(size * 0.4, 0),
          width: size,
          height: size * 1.2,
        ),
      )
      ..moveTo(center.dx + size * 0.1, center.dy + size * 0.2)
      ..quadraticBezierTo(
        center.dx + size * 0.4,
        center.dy - size * 0.1,
        center.dx + size * 0.7,
        center.dy + size * 0.2,
      );
    canvas.drawPath(sadPath, paint..style = PaintingStyle.stroke);
    canvas.drawCircle(
      center.translate(size * 0.4, -size * 0.2),
      size * 0.1,
      paint..style = PaintingStyle.fill,
    );
  }

  void _drawEnhancedNaturIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Tree trunk
    final trunkPath = ui.Path()
      ..moveTo(center.dx - size * 0.1, center.dy + size * 0.8)
      ..lineTo(center.dx + size * 0.1, center.dy + size * 0.8)
      ..lineTo(center.dx + size * 0.2, center.dy - size * 0.2)
      ..lineTo(center.dx - size * 0.2, center.dy - size * 0.2)
      ..close();
    canvas.drawPath(trunkPath, paint);

    // Tree crown
    canvas.drawCircle(center.translate(0, -size * 0.4), size * 0.6, paint);
  }

  void _drawEnhancedErholungIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Lotus pose
    // Head
    canvas.drawCircle(center.translate(0, -size * 0.5), size * 0.2, paint);
    // Body
    final bodyPath = ui.Path()
      ..moveTo(center.dx, center.dy - size * 0.3)
      ..lineTo(center.dx, center.dy + size * 0.2);
    canvas.drawPath(bodyPath, paint);
    // Legs
    final legPath = ui.Path()
      ..moveTo(center.dx - size * 0.6, center.dy + size * 0.5)
      ..quadraticBezierTo(
        center.dx,
        center.dy + size * 0.2,
        center.dx + size * 0.6,
        center.dy + size * 0.5,
      )
      ..moveTo(center.dx - size * 0.4, center.dy + size * 0.5)
      ..lineTo(center.dx - size * 0.7, center.dy + size * 0.6)
      ..moveTo(center.dx + size * 0.4, center.dy + size * 0.5)
      ..lineTo(center.dx + size * 0.7, center.dy + size * 0.6);
    canvas.drawPath(legPath, paint);
    // Arms
    final armPath = ui.Path()
      ..moveTo(center.dx - size * 0.4, center.dy)
      ..lineTo(center.dx + size * 0.4, center.dy);
    canvas.drawPath(armPath, paint);
  }

  void _drawEnhancedGeschichteIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Column
    final rect = Rect.fromCenter(
      center: center,
      width: size * 0.4,
      height: size * 1.2,
    );
    canvas.drawRect(rect, paint);
    // Base and top
    final basePath = ui.Path()
      ..moveTo(rect.left - size * 0.1, rect.bottom)
      ..lineTo(rect.right + size * 0.1, rect.bottom)
      ..moveTo(rect.left - size * 0.1, rect.top)
      ..lineTo(rect.right + size * 0.1, rect.top);
    canvas.drawPath(
      basePath,
      paint
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke,
    );
  }

  void _drawEnhancedArchitekturIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Building outline
    final path = ui.Path()
      ..moveTo(center.dx - size * 0.6, center.dy + size * 0.6)
      ..lineTo(center.dx - size * 0.6, center.dy - size * 0.6)
      ..lineTo(center.dx + size * 0.6, center.dy - size * 0.2)
      ..lineTo(center.dx + size * 0.6, center.dy + size * 0.6)
      ..close()
      // Roof line
      ..moveTo(center.dx - size * 0.6, center.dy - size * 0.6)
      ..lineTo(center.dx, center.dy - size);
    canvas.drawPath(path, paint);
  }

  void _drawEnhancedSportIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Soccer ball
    canvas.drawCircle(center, size, paint);
    // Hexagon pattern
    final path = ui.Path();
    for (int i = 0; i < 6; i++) {
      path.moveTo(
        center.dx + size * 0.5 * math.cos(math.pi / 3 * i),
        center.dy + size * 0.5 * math.sin(math.pi / 3 * i),
      );
      path.lineTo(
        center.dx + size * 0.5 * math.cos(math.pi / 3 * (i + 1)),
        center.dy + size * 0.5 * math.sin(math.pi / 3 * (i + 1)),
      );
    }
    canvas.drawPath(path, paint);
  }

  void _drawEnhancedBildungIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Open book
    final path = ui.Path()
      ..moveTo(center.dx - size * 0.8, center.dy - size * 0.1)
      ..quadraticBezierTo(
        center.dx,
        center.dy + size * 0.4,
        center.dx + size * 0.8,
        center.dy - size * 0.1,
      )
      ..moveTo(center.dx, center.dy - size * 0.1)
      ..lineTo(center.dx, center.dy + size * 0.4);
    canvas.drawPath(path, paint);
    // Page lines
    final linesPath = ui.Path()
      ..moveTo(center.dx - size * 0.6, center.dy)
      ..lineTo(center.dx - size * 0.2, center.dy)
      ..moveTo(center.dx - size * 0.6, center.dy + size * 0.2)
      ..lineTo(center.dx - size * 0.2, center.dy + size * 0.2)
      ..moveTo(center.dx + size * 0.6, center.dy)
      ..lineTo(center.dx + size * 0.2, center.dy)
      ..moveTo(center.dx + size * 0.6, center.dy + size * 0.2)
      ..lineTo(center.dx + size * 0.2, center.dy + size * 0.2);
    canvas.drawPath(linesPath, paint..strokeWidth = 1.0);
  }

  void _drawEnhancedSozialesIcon(
    Canvas canvas,
    Offset center,
    double size,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Three figures holding hands
    // Left figure
    canvas.drawCircle(
      center.translate(-size * 0.6, 0),
      size * 0.2,
      paint..style = PaintingStyle.fill,
    );
    final leftBody = ui.Path()
      ..moveTo(center.dx - size * 0.6, center.dy + size * 0.2)
      ..lineTo(center.dx - size * 0.6, center.dy + size * 0.6)
      ..lineTo(center.dx - size * 0.8, center.dy + size)
      ..moveTo(center.dx - size * 0.6, center.dy + size * 0.6)
      ..lineTo(center.dx - size * 0.4, center.dy + size);
    canvas.drawPath(leftBody, paint..style = PaintingStyle.stroke);

    // Center figure
    canvas.drawCircle(
      center.translate(0, -size * 0.2),
      size * 0.2,
      paint..style = PaintingStyle.fill,
    );
    final centerBody = ui.Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(center.dx, center.dy + size * 0.4)
      ..lineTo(center.dx - size * 0.2, center.dy + size * 0.8)
      ..moveTo(center.dx, center.dy + size * 0.4)
      ..lineTo(center.dx + size * 0.2, center.dy + size * 0.8);
    canvas.drawPath(centerBody, paint..style = PaintingStyle.stroke);

    // Right figure
    canvas.drawCircle(
      center.translate(size * 0.6, 0),
      size * 0.2,
      paint..style = PaintingStyle.fill,
    );
    final rightBody = ui.Path()
      ..moveTo(center.dx + size * 0.6, center.dy + size * 0.2)
      ..lineTo(center.dx + size * 0.6, center.dy + size * 0.6)
      ..lineTo(center.dx + size * 0.4, center.dy + size)
      ..moveTo(center.dx + size * 0.6, center.dy + size * 0.6)
      ..lineTo(center.dx + size * 0.8, center.dy + size);
    canvas.drawPath(rightBody, paint..style = PaintingStyle.stroke);

    // Holding hands
    final handsPath = ui.Path()
      ..moveTo(center.dx - size * 0.4, center.dy + size * 0.3)
      ..lineTo(center.dx - size * 0.1, center.dy + size * 0.2)
      ..moveTo(center.dx + size * 0.4, center.dy + size * 0.3)
      ..lineTo(center.dx + size * 0.1, center.dy + size * 0.2);
    canvas.drawPath(handsPath, paint);
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
      // Use current state color for checked-in spots
      return SpotColors(
        theme.currentState,
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
    switch (category.toLowerCase()) {
      case 'kultur & geschichte':
        return SpotColors(theme.accent, Colors.white);
      case 'genuss & kulinarik':
        return SpotColors(theme.opportunities, Colors.white);
      case 'architektur & besonderes':
        return SpotColors(theme.navigation, Colors.white);
      case 'architektur & geschichte':
        return SpotColors(theme.accent, Colors.white);
      case 'natur & ausblick':
        return SpotColors(theme.progress, Colors.white);
      case 'natur & geschichte':
        return SpotColors(theme.progress, Colors.white);
      case 'viewpoint':
      case 'aussichtspunkt':
        return SpotColors(theme.progress, Colors.white);
      case 'shop':
        return SpotColors(theme.navigation, Colors.white);
      case 'kultur':
        return SpotColors(theme.accent, Colors.white);
      case 'Natur & Ausblick':
        return SpotColors(theme.progress, Colors.white);
      case 'geschichte':
        return SpotColors(theme.accent, Colors.white);
      case 'architektur':
        return SpotColors(theme.navigation, Colors.white);
      case 'sport':
        return SpotColors(theme.navigation, Colors.white);
      case 'bildung':
        return SpotColors(theme.accent, Colors.white);
      case 'soziales':
      case 'gemeinschaft':
        return SpotColors(theme.opportunities, Colors.white);
      case 'infrastruktur':
      case 'verwaltung':
      case 'technik':
        return SpotColors(theme.navigation, Colors.white);
      case 'wirtschaft':
        return SpotColors(theme.opportunities, Colors.white);
      case 'gesundheit':
        return SpotColors(theme.error, Colors.white);
      case 'ökologie':
        return SpotColors(theme.progress, Colors.white);
      case 'wissenschaft':
        return SpotColors(theme.accent, Colors.white);
      default:
        return SpotColors(theme.onSurfaceVariant, Colors.white);
    }
  }

  @override
  bool shouldRepaint(CustomSpotPainter oldDelegate) {
    return oldDelegate.spots != spots ||
        oldDelegate.camera != camera ||
        oldDelegate.selectedSpot != selectedSpot ||
        oldDelegate.userSpotVisitData != userSpotVisitData ||
        oldDelegate.theme != theme;
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
      return distanceSquared <= radiusSquared && distanceSquared >= innerRadiusSquared;
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
