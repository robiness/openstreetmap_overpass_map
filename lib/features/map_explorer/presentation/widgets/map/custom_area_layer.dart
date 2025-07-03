import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/app/theme/theme_provider.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/data/models/user_area_data.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/map/custom_area_painter.dart';

class CustomAreaLayer extends StatelessWidget {
  final List<GeographicArea> areas;
  final void Function(GeographicArea, LatLng)? onAreaTap;
  final GeographicArea? selectedArea;
  final Map<int, UserAreaData> userVisitData;

  const CustomAreaLayer({
    super.key,
    required this.areas,
    this.onAreaTap,
    this.selectedArea,
    this.userVisitData = const {},
  });

  @override
  Widget build(BuildContext context) {
    final camera = MapCamera.of(context);
    final theme = context.appTheme;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapUp: (details) {
        // We use onTapUp to be less "greedy" in the gesture arena, allowing
        // pan and zoom gestures to be handled by the map below.
        if (onAreaTap == null) return;

        final tappedLatLng = camera.offsetToCrs(details.localPosition);

        // First check if tap is on the selected area (since it's drawn on top)
        if (selectedArea != null) {
          for (final polygonRings in selectedArea!.coordinates) {
            final polygon = polygonRings.map((coords) => LatLng(coords[1], coords[0])).toList();
            if (_isPointInPolygon(tappedLatLng, polygon)) {
              onAreaTap!(selectedArea!, tappedLatLng);
              return; // Stop after finding the match
            }
          }
        }

        // Then check other areas (iterate backwards to check top-most layers first)
        for (final area in areas.reversed) {
          // Skip the selected area since we already checked it
          if (selectedArea != null && area.id == selectedArea!.id) {
            continue;
          }

          for (final polygonRings in area.coordinates) {
            final polygon = polygonRings.map((coords) => LatLng(coords[1], coords[0])).toList();
            if (_isPointInPolygon(tappedLatLng, polygon)) {
              onAreaTap!(area, tappedLatLng);
              return; // Stop after finding the first match
            }
          }
        }
      },
      child: CustomPaint(
        painter: CustomAreaPainter(
          areas: areas,
          camera: camera,
          theme: theme,
          selectedArea: selectedArea,
          userVisitData: userVisitData,
        ),
        size: Size.infinite,
      ),
    );
  }

  /// Checks if a point is inside a polygon using the Ray-Casting algorithm.
  bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
    if (polygon.length < 3) {
      return false;
    }

    bool isInside = false;
    int j = polygon.length - 1;
    for (int i = 0; i < polygon.length; i++) {
      final p1 = polygon[i];
      final p2 = polygon[j];

      final isYBetween = (p1.latitude > point.latitude) != (p2.latitude > point.latitude);
      final isXBefore =
          point.longitude <
          (p2.longitude - p1.longitude) * (point.latitude - p1.latitude) / (p2.latitude - p1.latitude) + p1.longitude;

      if (isYBetween && isXBefore) {
        isInside = !isInside;
      }
      j = i;
    }

    return isInside;
  }
}
