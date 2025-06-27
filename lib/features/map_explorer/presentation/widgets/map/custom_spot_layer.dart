import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/map/custom_spot_painter.dart';

class CustomSpotLayer extends StatelessWidget {
  final List<Spot> spots;
  final void Function(Spot)? onSpotTap;
  final Spot? selectedSpot;

  const CustomSpotLayer({
    super.key,
    required this.spots,
    this.onSpotTap,
    this.selectedSpot,
  });

  @override
  Widget build(BuildContext context) {
    final camera = MapCamera.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapUp: (details) {
        if (onSpotTap == null) return;

        final tappedLatLng = camera.offsetToCrs(details.localPosition);

        // Check if any spot was tapped (with a small radius for easier tapping)
        const tapRadius = 20.0; // pixels

        for (final spot in spots) {
          final spotScreenPoint = camera.latLngToScreenOffset(spot.location);
          final tapScreenPoint = camera.latLngToScreenOffset(tappedLatLng);

          final distance = _calculateDistance(spotScreenPoint, tapScreenPoint);

          if (distance <= tapRadius) {
            onSpotTap!(spot);
            return;
          }
        }
      },
      child: CustomPaint(
        painter: CustomSpotPainter(
          spots: spots,
          camera: camera,
          selectedSpot: selectedSpot,
        ),
        size: Size.infinite,
      ),
    );
  }

  double _calculateDistance(Offset point1, Offset point2) {
    final dx = point1.dx - point2.dx;
    final dy = point1.dy - point2.dy;
    return math.sqrt(dx * dx + dy * dy);
  }
}
