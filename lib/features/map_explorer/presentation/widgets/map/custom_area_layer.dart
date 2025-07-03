import 'dart:ui' as ui;

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

    // Sort areas by exploration status for correct draw order
    final sortedAreas = List<GeographicArea>.from(areas);
    sortedAreas.sort((a, b) {
      final statusA =
          userVisitData[a.id]?.status ?? AreaExplorationStatus.unvisited;
      final statusB =
          userVisitData[b.id]?.status ?? AreaExplorationStatus.unvisited;
      return statusA.index.compareTo(statusB.index);
    });

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapUp: (details) {
        if (onAreaTap == null) return;

        final tapPosition = details.localPosition;
        final matchingAreas = <GeographicArea>[];

        // Find all areas that contain the tap position
        for (final area in sortedAreas) {
          final path = _getScreenPathForArea(area, camera);
          if (path != null && path.contains(tapPosition)) {
            matchingAreas.add(area);
          }
        }

        if (matchingAreas.isEmpty) {
          return; // No area was tapped
        }

        // Of the areas that were tapped, find the one with the highest admin level
        // (e.g., Stadtteil level 9 > Bezirk level 8 > City level 6)
        matchingAreas.sort((a, b) => b.adminLevel.compareTo(a.adminLevel));
        final tappedArea = matchingAreas.first;

        final tappedLatLng = camera.offsetToCrs(tapPosition);
        onAreaTap!(tappedArea, tappedLatLng);
      },
      child: CustomPaint(
        painter: CustomAreaPainter(
          areas: sortedAreas,
          camera: camera,
          theme: theme,
          selectedArea: selectedArea,
          userVisitData: userVisitData,
        ),
        size: Size.infinite,
      ),
    );
  }

  ui.Path? _getScreenPathForArea(GeographicArea area, MapCamera camera) {
    final allPaths = ui.Path();

    for (final coordinateRing in area.coordinates) {
      if (coordinateRing.length < 3) continue;

      final offsets = <Offset>[];
      final mapOrigin = camera.pixelOrigin;

      for (final point in coordinateRing) {
        final latLng = LatLng(point[1], point[0]);
        final projectedPoint = camera.crs.latLngToOffset(latLng, camera.zoom);
        final screenPoint = projectedPoint - mapOrigin;
        offsets.add(Offset(screenPoint.dx, screenPoint.dy));
      }

      if (offsets.isNotEmpty) {
        final path = ui.Path();
        path.moveTo(offsets.first.dx, offsets.first.dy);
        for (int i = 1; i < offsets.length; i++) {
          path.lineTo(offsets[i].dx, offsets[i].dy);
        }
        path.close();
        allPaths.addPath(path, Offset.zero);
      }
    }
    return allPaths.getBounds().isEmpty ? null : allPaths;
  }
}
