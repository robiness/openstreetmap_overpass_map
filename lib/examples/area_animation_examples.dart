import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../models/osm_models.dart';
import '../widgets/custom_area_painter.dart';

/// Examples of advanced animations and shader effects for areas
class AreaAnimationExamples {
  /// Create a pulsing animation for selected areas
  static AnimationController createPulsingAnimation({
    required TickerProvider vsync,
    Duration duration = const Duration(seconds: 2),
  }) {
    final controller = AnimationController(
      duration: duration,
      vsync: vsync,
    );

    // Repeat the animation infinitely
    controller.repeat(reverse: true);
    return controller;
  }

  /// Create a wave animation that sweeps across areas
  static Animation<double> createWaveAnimation({
    required AnimationController controller,
    double delay = 0.0,
  }) {
    return Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          delay,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  /// Create animated areas with different effects based on visit count
  static List<AnimatedArea> createVisitBasedAnimatedAreas({
    required List<GeographicArea> areas,
    required Map<int, int> visitCounts,
    required Size screenSize,
  }) {
    return areas.map((area) {
      final visitCount = visitCounts[area.id] ?? 0;

      // More visits = more vibrant colors and effects
      final intensity = (visitCount / 10.0).clamp(0.0, 1.0);

      Color baseColor;
      switch (area.type) {
        case 'city':
          baseColor = Colors.red;
          break;
        case 'bezirk':
          baseColor = Colors.blue;
          break;
        case 'stadtteil':
          baseColor = Colors.green;
          break;
        default:
          baseColor = Colors.grey;
      }

      // Create gradient shader based on visit intensity
      ui.Shader? shader;
      if (visitCount > 0) {
        shader = ui.Gradient.radial(
          Offset(screenSize.width / 2, screenSize.height / 2),
          screenSize.width / 3,
          [
            baseColor.withOpacity(0.1 + intensity * 0.7),
            baseColor.withOpacity(0.8),
            baseColor.withOpacity(0.1),
          ],
          [0.0, 0.5 + intensity * 0.3, 1.0],
        );
      }

      return AnimatedArea(
        geoArea: area,
        fillColor: baseColor.withOpacity(0.3 + intensity * 0.4),
        borderColor: baseColor.withOpacity(0.6 + intensity * 0.4),
        fillOpacity: 0.3 + intensity * 0.3,
        borderWidth: 1.0 + intensity * 3.0,
        shader: shader,
      );
    }).toList();
  }

  /// Create a rainbow sweep effect
  static ui.Shader createRainbowSweepShader({
    required Offset center,
    required double radius,
    double rotationAngle = 0.0,
  }) {
    return ui.Gradient.sweep(
      center,
      [
        Colors.red,
        Colors.orange,
        Colors.yellow,
        Colors.green,
        Colors.blue,
        Colors.indigo,
        Colors.purple,
        Colors.red,
      ],
      null, // Equal stops
      TileMode.clamp,
      rotationAngle,
      rotationAngle + 6.283185307179586, // 2 * pi
    );
  }

  /// Create a metallic gradient shader
  static ui.Shader createMetallicShader({
    required Offset from,
    required Offset to,
    Color baseColor = Colors.blue,
  }) {
    return ui.Gradient.linear(
      from,
      to,
      [
        baseColor.withOpacity(0.3),
        Colors.white.withOpacity(0.8),
        baseColor.withOpacity(0.6),
        Colors.black.withOpacity(0.2),
        baseColor.withOpacity(0.9),
      ],
      [0.0, 0.2, 0.5, 0.8, 1.0],
    );
  }

  /// Create a fire effect shader
  static ui.Shader createFireShader({
    required Offset center,
    required double radius,
  }) {
    return ui.Gradient.radial(
      center,
      radius,
      [
        Colors.yellow,
        Colors.orange,
        Colors.red,
        Colors.black.withOpacity(0.8),
      ],
      [0.0, 0.3, 0.7, 1.0],
    );
  }

  /// Create animated area with morphing colors
  static AnimatedArea createMorphingColorArea({
    required GeographicArea area,
    required Animation<double> animation,
    required List<Color> colors,
  }) {
    // Calculate current color based on animation value
    final colorIndex = (animation.value * (colors.length - 1)).floor();
    final nextColorIndex = (colorIndex + 1).clamp(0, colors.length - 1);
    final t = (animation.value * (colors.length - 1)) - colorIndex;

    final currentColor =
        Color.lerp(
          colors[colorIndex],
          colors[nextColorIndex],
          t,
        ) ??
        colors.first;

    return AnimatedArea(
      geoArea: area,
      fillColor: currentColor,
      borderColor: currentColor.withOpacity(0.8),
      fillOpacity: 0.3,
      borderWidth: 2.0,
    );
  }

  /// Create breathing animation (scaling border width)
  static AnimatedArea createBreathingArea({
    required GeographicArea area,
    required Animation<double> animation,
    Color? color,
  }) {
    final areaColor = color ?? Colors.blue;
    final breathingWidth = 1.0 + animation.value * 4.0;

    return AnimatedArea(
      geoArea: area,
      fillColor: areaColor,
      borderColor: areaColor.withOpacity(0.8),
      fillOpacity: 0.2 + animation.value * 0.3,
      borderWidth: breathingWidth,
    );
  }
}
