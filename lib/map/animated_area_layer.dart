import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../data/osm_models.dart';
import 'custom_area_painter.dart';

/// An animated layer for drawing geographic areas with custom paint
class AnimatedAreaLayer extends StatefulWidget {
  final List<GeographicArea> areas;
  final Curve animationCurve;
  final Map<int, ui.Shader>? shadersByAreaId;
  final GeographicArea? selectedArea;
  final Set<int>? visitedAreaIds;
  final Set<int>? completedAreaIds;
  final Set<int>? partialAreaIds;
  final Set<int>? unvisitedAreaIds;
  final Color selectionColor;
  final Color visitedColor;
  final Color completedColor;
  final Color partialColor;
  final Color unvisitedColor;

  const AnimatedAreaLayer({
    super.key,
    required this.areas,
    this.animationCurve = Curves.easeInOut,
    this.shadersByAreaId,
    this.selectedArea,
    this.visitedAreaIds,
    this.completedAreaIds,
    this.partialAreaIds,
    this.unvisitedAreaIds,
    this.selectionColor = Colors.orange,
    this.visitedColor = Colors.purple,
    this.completedColor = Colors.green,
    this.partialColor = Colors.amber,
    this.unvisitedColor = Colors.grey,
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
    _animationController.forward();
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve,
    );
  }

  @override
  void didUpdateWidget(AnimatedAreaLayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Restart animation if areas changed and animation is enabled
    if (widget.areas != oldWidget.areas && mounted) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
          final defaultColor = Colors.grey;

          // Determine visual properties based on exploration state
          Color fillColor;
          double fillOpacity;
          double borderWidth;
          bool isDashed = false;
          bool hasShadow = false;

          final isSelected = widget.selectedArea?.id == area.id;
          final isCompleted = widget.completedAreaIds?.contains(area.id) == true;
          final isPartial = widget.partialAreaIds?.contains(area.id) == true;
          final isUnvisited = widget.unvisitedAreaIds?.contains(area.id) == true;

          // Handle backward compatibility with visitedAreaIds
          final isVisited = widget.visitedAreaIds?.contains(area.id) == true;

          // Prioritize exploration states over old visited system
          if (isSelected) {
            // Selected area: always gets selection color with pulsing
            fillColor = widget.selectionColor;
            fillOpacity = 0.5;
            borderWidth = 4.0;
            hasShadow = true;
          } else if (isCompleted) {
            // Completed areas: vibrant green with solid fill
            fillColor = widget.completedColor;
            fillOpacity = 0.6;
            borderWidth = 3.0;
            hasShadow = true;
          } else if (isPartial) {
            // Partial areas: amber/yellow with moderate fill
            fillColor = widget.partialColor;
            fillOpacity = 0.4;
            borderWidth = 2.5;
            isDashed = true;
          } else if (isUnvisited) {
            // Unvisited areas: light gray with minimal fill
            fillColor = widget.unvisitedColor;
            fillOpacity = 0.15;
            borderWidth = 1.5;
          } else if (isVisited) {
            // Fallback to old visited system for backward compatibility
            fillColor = widget.visitedColor;
            fillOpacity = 0.25;
            borderWidth = 3.0;
            isDashed = true;
          } else {
            // Default: completely transparent
            fillColor = defaultColor;
            fillOpacity = 0.0;
            borderWidth = 1.0;
          }

          // Enhanced border color logic
          Color borderColor;
          if (isSelected) {
            borderColor = widget.selectionColor.withValues(alpha: 0.9);
          } else if (isCompleted) {
            borderColor = widget.completedColor.withValues(alpha: 0.9);
          } else if (isPartial) {
            borderColor = widget.partialColor.withValues(alpha: 0.8);
          } else if (isUnvisited) {
            borderColor = widget.unvisitedColor.withValues(alpha: 0.6);
          } else if (isVisited) {
            borderColor = widget.visitedColor.withValues(alpha: 0.8);
          } else {
            borderColor = defaultColor.withValues(alpha: 0.3);
          }

          return AnimatedArea(
            geoArea: area,
            fillColor: Colors.grey,
            borderColor: Colors.black,
            fillOpacity: fillOpacity,
            borderWidth: 5,
            isDashed: isDashed,
            hasShadow: hasShadow,
            shadowColor: isSelected
                ? widget.selectionColor.withValues(alpha: 0.3)
                : isCompleted
                ? widget.completedColor.withValues(alpha: 0.2)
                : null,
          );
        }).toList();

        return CustomPaint(
          isComplex: true,
          painter: CustomAreaPainter(
            areas: animatedAreas,
            camera: mapState,
            animation: _animation,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}
