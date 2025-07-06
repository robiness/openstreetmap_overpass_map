import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/map/custom_spot_painter.dart';

class CustomSpotLayer extends StatelessWidget {
  final List<Spot> spots;
  final void Function(Spot)? onSpotTap;
  final Spot? selectedSpot;
  final Map<String, UserSpotData> userSpotVisitData;

  const CustomSpotLayer({
    super.key,
    required this.spots,
    this.onSpotTap,
    this.selectedSpot,
    this.userSpotVisitData = const {},
  });

  @override
  Widget build(BuildContext context) {
    final camera = MapCamera.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTapUp: (details) {
        if (onSpotTap == null) return;

        // Find which spot was tapped using pixel-perfect detection
        final tappedSpot = _findTappedSpot(details.localPosition, camera);
        if (tappedSpot != null) {
          onSpotTap!(tappedSpot);
        }
        // If no spot was hit, don't consume the event - let it pass through
      },
      child: CustomPaint(
        painter: CustomSpotPainter(
          spots: spots,
          camera: camera,
          selectedSpot: selectedSpot,
          userSpotVisitData: userSpotVisitData,
        ),
        size: Size.infinite,
      ),
    );
  }

  Spot? _findTappedSpot(Offset position, MapCamera camera) {
    // Test in the same order as the painter: non-selected first, then selected
    final nonSelectedSpots = <Spot>[];
    final selectedSpots = <Spot>[];

    for (final spot in spots) {
      final isSelected = spot.id == selectedSpot?.id;
      if (isSelected) {
        selectedSpots.add(spot);
      } else {
        nonSelectedSpots.add(spot);
      }
    }

    // Test non-selected spots first
    for (final spot in nonSelectedSpots) {
      if (_testSpotHit(position, spot, false, camera)) {
        return spot;
      }
    }

    // Test selected spots last (they're painted on top)
    for (final spot in selectedSpots) {
      if (_testSpotHit(position, spot, true, camera)) {
        return spot;
      }
    }

    return null;
  }

  bool _testSpotHit(
    Offset position,
    Spot spot,
    bool isSelected,
    MapCamera camera,
  ) {
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
