import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';

abstract class MapRepository {
  Future<BoundaryData> getCityBoundaryData({
    required String cityName,
    int cityAdminLevel = 6,
  });

  Future<List<Spot>> getSpots({
    required String cityName,
    List<String> categories = const [
      'restaurant',
      'cafe',
      'bar',
      'biergarten',
      'viewpoint',
      'shop',
    ],
  });
}
