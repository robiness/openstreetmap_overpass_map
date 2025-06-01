import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:overpass_map/overpass_json_parser.dart';

class OverpassApi {
  final String _baseUrl;

  OverpassApi({String baseUrl = 'https://overpass-api.de/api/interpreter'}) : _baseUrl = baseUrl;

  /// Single query to get all administrative boundaries for a city in one request
  Future<OverPassAPIResult> getCityData(String cityName, {int cityAdminLevel = 6}) async {
    // Single query that gets city (level 6), bezirke (level 9), and stadtteile (level 10)
    // and sub-boundaries (admin_level 9 and 10) within that city.
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

    try {
      print("Single query for $cityName with all admin levels");
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'data': query},
      );

      if (response.statusCode == 200) {
        final result = response.body;
        final decodedBody = json.decode(result);

        if (decodedBody['remark'] != null && decodedBody['remark'].toString().contains('Error')) {
          throw Exception('Overpass API error: ${decodedBody['remark']}');
        }

        return OverPassAPIResult(
          query: query,
          result: result,
          boundaryData: BoundaryData(decodedBody),
        );
      } else {
        throw Exception('Failed to load data for $cityName. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data for $cityName: $e');
      rethrow;
    }
  }
}

class OverPassAPIResult {
  final String query;
  final String result;
  final BoundaryData boundaryData;

  OverPassAPIResult({
    required this.query,
    required this.result,
    required this.boundaryData,
  });
}
