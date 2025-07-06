import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';

// Simple model for city list
class AvailableCity {
  final int id;
  final String name;
  final int adminLevel;

  const AvailableCity({
    required this.id,
    required this.name,
    required this.adminLevel,
  });
}

abstract class MapRepository {
  Future<BoundaryData> getCityBoundaryData({
    required String cityName,
    int cityAdminLevel = 6,
  });

  Future<List<Spot>> getSpots();

  // New method to get available cities
  Future<List<AvailableCity>> getAvailableCities({
    int cityAdminLevel = 6,
  });
}
