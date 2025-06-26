import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/map/custom_area_painter.dart';

class CustomAreaLayer extends StatelessWidget {
  final List<GeographicArea> areas;

  const CustomAreaLayer({super.key, required this.areas});

  @override
  Widget build(BuildContext context) {
    final camera = MapCamera.of(context);

    return CustomPaint(
      painter: CustomAreaPainter(
        areas: areas,
        camera: camera,
      ),
      size: Size.infinite,
    );
  }
}
