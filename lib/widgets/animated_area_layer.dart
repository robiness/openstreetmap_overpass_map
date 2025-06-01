import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../models/osm_models.dart';
import 'custom_area_painter.dart';

/// An animated layer for drawing geographic areas with custom paint
class AnimatedAreaLayer extends StatefulWidget {
  final List<GeographicArea> areas;
  final Map<String, Color>? colorsByType;
  final Duration animationDuration;
  final Curve animationCurve;
  final bool enableAnimation;
  final Map<int, ui.Shader>? shadersByAreaId;
  final VoidCallback? onAnimationComplete;

  const AnimatedAreaLayer({
    super.key,
    required this.areas,
    this.colorsByType,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.animationCurve = Curves.easeInOut,
    this.enableAnimation = true,
    this.shadersByAreaId,
    this.onAnimationComplete,
  });

  @override
  State<AnimatedAreaLayer> createState() => _AnimatedAreaLayerState();
}

class _AnimatedAreaLayerState extends State<AnimatedAreaLayer> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    if (widget.enableAnimation) {
      _animationController.forward();
    }
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve,
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationComplete?.call();
      }
    });
  }

  @override
  void didUpdateWidget(AnimatedAreaLayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Restart animation if areas changed and animation is enabled
    if (widget.enableAnimation && widget.areas != oldWidget.areas && mounted) {
      _animationController.reset();
      _animationController.forward();
    }

    // Update animation duration if changed
    if (widget.animationDuration != oldWidget.animationDuration) {
      _animationController.duration = widget.animationDuration;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getAreaColor(GeographicArea area) {
    return widget.colorsByType?[area.type] ?? _getDefaultColor(area.type);
  }

  Color _getDefaultColor(String type) {
    switch (type) {
      case 'city':
        return Colors.red;
      case 'bezirk':
        return Colors.blue;
      case 'stadtteil':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  /// Animate to a specific area by focusing on it
  void animateToArea(
    GeographicArea area, {
    Color? highlightColor,
    Duration? duration,
  }) {
    // This could be enhanced to create a special animation for the selected area
    _animationController.reset();
    _animationController.forward();
  }

  /// Start pulsing animation for a specific area
  void startPulsingArea(int areaId) {
    // Implementation for pulsing animation could be added here
    _animationController.repeat(reverse: true);
  }

  /// Stop any ongoing animations
  void stopAnimations() {
    _animationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get the map camera from the inherited widget
        final mapState = MapCamera.maybeOf(context);
        if (mapState == null) {
          return const SizedBox.shrink();
        }

        // Create animated areas
        final animatedAreas = widget.areas.map((area) {
          final color = _getAreaColor(area);
          final shader = widget.shadersByAreaId?[area.id];

          return AnimatedArea(
            geoArea: area,
            fillColor: color,
            borderColor: color.withValues(alpha: 0.8),
            fillOpacity: 0.3,
            borderWidth: 2.0,
            shader: shader,
          );
        }).toList();

        return CustomPaint(
          painter: CustomAreaPainter(
            areas: animatedAreas,
            camera: mapState,
            animation: widget.enableAnimation ? _animation : null,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

/// Helper methods for creating shaders
class AreaShaders {
  /// Create a linear gradient shader
  static ui.Shader createLinearGradient({
    required List<Color> colors,
    required Offset from,
    required Offset to,
    List<double>? stops,
  }) {
    return ui.Gradient.linear(
      from,
      to,
      colors,
      stops,
    );
  }

  /// Create a radial gradient shader
  static ui.Shader createRadialGradient({
    required List<Color> colors,
    required Offset center,
    required double radius,
    List<double>? stops,
  }) {
    return ui.Gradient.radial(
      center,
      radius,
      colors,
      stops,
    );
  }

  /// Create a sweep gradient shader (circular gradient)
  static ui.Shader createSweepGradient({
    required List<Color> colors,
    required Offset center,
    double startAngle = 0.0,
    double endAngle = 6.283185307179586, // 2 * pi
    List<double>? stops,
  }) {
    return ui.Gradient.sweep(
      center,
      colors,
      stops,
      TileMode.clamp,
      startAngle,
      endAngle,
    );
  }
}
