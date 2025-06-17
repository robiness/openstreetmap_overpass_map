import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../data/osm_models.dart';
import 'custom_area_painter.dart';

/// An animated layer for drawing geographic areas with custom paint
class AnimatedAreaLayer extends StatelessWidget {
  final List<GeographicArea> areas;

  const AnimatedAreaLayer({
    super.key,
    required this.areas,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get the map camera from the inherited widget
        final camera = MapCamera.maybeOf(context);
        if (camera == null) {
          return const SizedBox.shrink();
        }

        return CustomPaint(
          painter: CustomAreaPainter(
            areas: areas,
            camera: camera,
          ),
        );
      },
    );
  }
}
