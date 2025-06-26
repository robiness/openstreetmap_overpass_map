import 'package:overpass_map/data/repositories/map_repository.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/data/sources/overpass_api_data_source.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';

class MapRepositoryImpl implements MapRepository {
  final OverpassApiDataSource _apiDataSource;

  MapRepositoryImpl({OverpassApiDataSource? apiDataSource})
    : _apiDataSource = apiDataSource ?? OverpassApiDataSource();

  @override
  Future<BoundaryData> getCityBoundaryData({
    required String cityName,
    int cityAdminLevel = 6,
  }) async {
    final result = await _apiDataSource.getCityData(
      cityName,
      cityAdminLevel: cityAdminLevel,
    );
    if (result.data == null) {
      throw Exception('Failed to load boundary data for $cityName');
    }
    return result.data!;
  }

  @override
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
  }) async {
    return await _apiDataSource.getSpots(
      cityName: cityName,
      categories: categories,
    );
  }
}
