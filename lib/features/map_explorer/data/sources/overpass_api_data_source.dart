import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:overpass_map/features/map_explorer/data/sources/cache_service.dart';

import '../models/boundary_data.dart'; // Use this BoundaryData
import '../../domain/entities/spot.dart';

class CityDataResult {
  final BoundaryData?
  data; // This will now be the BoundaryData from overpass_json_parser
  final String source;
  final int duration;
  final String query;

  CityDataResult({
    required this.data,
    required this.source,
    required this.duration,
    required this.query,
  });
}

class OverpassApiDataSource {
  final String _baseUrl;
  final CacheService _cacheService;

  OverpassApiDataSource({
    String baseUrl = 'https://overpass-api.de/api/interpreter',
  }) : _baseUrl = baseUrl,
       _cacheService = CacheService();

  Future<CityDataResult> getCityData(
    String cityName, {
    int cityAdminLevel = 6,
  }) async {
    final stopwatch = Stopwatch()..start();
    final String query =
        """
[out:json][timeout:30];
(
  relation["name"="$cityName"]["boundary"="administrative"]["admin_level"="$cityAdminLevel"]["type"="boundary"];
)->.city_main_boundary;
(.city_main_boundary; map_to_area;)->.city_area;
(
  relation(area.city_area)["boundary"="administrative"]["admin_level"="9"]["type"="boundary"];
  relation(area.city_area)["boundary"="administrative"]["admin_level"="10"]["type"="boundary"];
)->.sub_level_boundaries;
(
  .city_main_boundary;
  .sub_level_boundaries;
);
out geom;
""";

    final cacheResponse = await _cacheService.get(query);
    final cachedJsonData =
        cacheResponse?['data']; // This is Map<String, dynamic>
    final cacheSource = cacheResponse?['source'] as String? ?? 'cache_error';
    final cacheDuration = cacheResponse?['duration'] as int? ?? 0;

    if (cachedJsonData != null) {
      stopwatch.stop();
      return CityDataResult(
        // Pass the raw JSON map to the constructor of BoundaryData from overpass_json_parser
        data: BoundaryData(cachedJsonData as Map<String, dynamic>),
        source: cacheSource,
        duration: cacheDuration,
        query: query,
      );
    }

    print("Cache miss for $cityName, fetching from network.");
    final networkStopwatch = Stopwatch()..start();
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'data': query},
    );

    if (response.statusCode == 200) {
      final decodedBody = json.decode(response.body) as Map<String, dynamic>;
      await _cacheService.put(query, decodedBody);
      networkStopwatch.stop();
      return CityDataResult(
        // Pass the raw JSON map to the constructor of BoundaryData from overpass_json_parser
        data: BoundaryData(decodedBody),
        source: 'network',
        duration: networkStopwatch.elapsedMilliseconds,
        query: query,
      );
    } else {
      networkStopwatch.stop();
      throw Exception(
        'Failed to load data from Overpass API: ${response.statusCode}',
      );
    }
  }

  /// Fetch spots (POIs) within a given area
  Future<List<Spot>> getSpots({
    required String cityName,
    List<String> categories = const [
      'restaurant',
      'cafe',
      'bar',
      'biergarten',
      'viewpoint',
    ],
    int maxSpots = 500,
  }) async {
    final stopwatch = Stopwatch()..start();

    // Build category filters for Overpass query
    final categoryFilters = _buildCategoryFilters(categories);

    final String query =
        """
[out:json][timeout:30];
(
  relation["name"="$cityName"]["boundary"="administrative"]["admin_level"="6"]["type"="boundary"];
)->.city_main_boundary;
(.city_main_boundary; map_to_area;)->.city_area;
(
  $categoryFilters
);
out geom $maxSpots;
""";

    final cacheResponse = await _cacheService.get(query);
    final cachedJsonData = cacheResponse?['data'];

    Map<String, dynamic> jsonData;
    if (cachedJsonData != null) {
      jsonData = cachedJsonData as Map<String, dynamic>;
    } else {
      print("Cache miss for spots in $cityName, fetching from network.");
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'data': query},
      );

      if (response.statusCode == 200) {
        jsonData = json.decode(response.body) as Map<String, dynamic>;
        await _cacheService.put(query, jsonData);
      } else {
        throw Exception(
          'Failed to load spots from Overpass API: ${response.statusCode}',
        );
      }
    }

    stopwatch.stop();
    print("Spots fetch completed in ${stopwatch.elapsedMilliseconds}ms");

    return _parseSpots(jsonData);
  }

  String _buildCategoryFilters(List<String> categories) {
    final filters = <String>[];

    for (final category in categories) {
      switch (category) {
        case 'restaurant':
          filters.add('node(area.city_area)["amenity"="restaurant"];');
          break;
        case 'cafe':
          filters.add('node(area.city_area)["amenity"="cafe"];');
          break;
        case 'bar':
          filters.add('node(area.city_area)["amenity"="bar"];');
          break;
        case 'biergarten':
          filters.add('node(area.city_area)["amenity"="biergarten"];');
          break;
        case 'pub':
          filters.add('node(area.city_area)["amenity"="pub"];');
          break;
        case 'fast_food':
          filters.add('node(area.city_area)["amenity"="fast_food"];');
          break;
        case 'viewpoint':
          filters.add('node(area.city_area)["tourism"="viewpoint"];');
          break;
        case 'shop':
          filters.add('node(area.city_area)["shop"];');
          break;
      }
    }

    return filters.join('\n  ');
  }

  List<Spot> _parseSpots(Map<String, dynamic> jsonData) {
    final elements = jsonData['elements'] as List<dynamic>? ?? [];
    final spots = <Spot>[];

    for (final element in elements) {
      if (element['type'] == 'node' &&
          element['lat'] != null &&
          element['lon'] != null) {
        try {
          final spot = Spot.fromOsmNode(element as Map<String, dynamic>);
          spots.add(spot);
        } catch (e) {
          print("Error parsing spot: $e");
          // Continue with other spots
        }
      }
    }

    return spots;
  }
}
