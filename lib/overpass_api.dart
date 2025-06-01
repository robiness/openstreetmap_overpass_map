import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:overpass_map/services/cache_service.dart';

import 'models/boundary_data.dart'; // Use this BoundaryData

class CityDataResult {
  final BoundaryData? data; // This will now be the BoundaryData from overpass_json_parser
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

class OverpassApi {
  final String _baseUrl;
  final CacheService _cacheService;

  OverpassApi({String baseUrl = 'https://overpass-api.de/api/interpreter'})
    : _baseUrl = baseUrl,
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
    final cachedJsonData = cacheResponse?['data']; // This is Map<String, dynamic>
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
      throw Exception('Failed to load data from Overpass API: ${response.statusCode}');
    }
  }
}
