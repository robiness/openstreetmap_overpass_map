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
  final GeographicArea? selectedArea;
  final Set<int>? visitedAreaIds;
  final Color selectionColor;
  final Color visitedColor;

  const AnimatedAreaLayer({
    super.key,
    required this.areas,
    this.colorsByType,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.animationCurve = Curves.easeInOut,
    this.enableAnimation = true,
    this.shadersByAreaId,
    this.onAnimationComplete,
    this.selectedArea,
    this.visitedAreaIds,
    this.selectionColor = Colors.orange,
    this.visitedColor = Colors.purple,
  });

  @override
  State<AnimatedAreaLayer> createState() => _AnimatedAreaLayerState();
}

class _AnimatedAreaLayerState extends State<AnimatedAreaLayer> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _setupPulseAnimation();
    if (widget.enableAnimation) {
      _animationController.forward();
    }
    // Start pulsing animation for visual feedback
    _pulseController.repeat(reverse: true);
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

  void _setupPulseAnimation() {
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
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
    _pulseController.dispose();
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
          final defaultColor = _getAreaColor(area);
          final shader = widget.shadersByAreaId?[area.id];

          // Determine visual properties based on state
          Color fillColor;
          double fillOpacity;
          double borderWidth;
          bool isDashed = false;
          bool hasShadow = false;
          double pulseScale = 1.0;
          
          final isSelected = widget.selectedArea?.id == area.id;
          final isVisited = widget.visitedAreaIds?.contains(area.id) == true;
          
          if (isSelected && isVisited) {
            // Both selected AND visited: enhanced orange fill with thick dashed purple border
            fillColor = widget.selectionColor;
            fillOpacity = 0.5;
            borderWidth = 4.0;
            isDashed = true;
            hasShadow = true;
            pulseScale = _pulseAnimation.value;
          } else if (isSelected) {
            // Only selected: bright orange fill with pulsing effect
            fillColor = widget.selectionColor;
            fillOpacity = 0.4;
            borderWidth = 3.5;
            hasShadow = true;
            pulseScale = _pulseAnimation.value;
          } else if (isVisited) {
            // Only visited: purple fill with dashed border
            fillColor = widget.visitedColor;
            fillOpacity = 0.25;
            borderWidth = 3.0;
            isDashed = true;
          } else {
            // Default: transparent with thin solid border
            fillColor = defaultColor;
            fillOpacity = 0.0;
            borderWidth = 1.5;
          }

          // Enhanced border color logic
          Color borderColor;
          if (isSelected && isVisited) {
            borderColor = widget.visitedColor.withValues(alpha: 0.9);
          } else if (isSelected) {
            borderColor = widget.selectionColor.withValues(alpha: 0.9);
          } else if (isVisited) {
            borderColor = widget.visitedColor.withValues(alpha: 0.8);
          } else {
            borderColor = defaultColor.withValues(alpha: 0.8);
          }

          return AnimatedArea(
            geoArea: area,
            fillColor: fillColor,
            borderColor: borderColor,
            fillOpacity: fillOpacity,
            borderWidth: borderWidth * pulseScale,
            shader: shader,
            isDashed: isDashed,
            hasShadow: hasShadow,
            shadowColor: isSelected ? widget.selectionColor.withValues(alpha: 0.3) : null,
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
