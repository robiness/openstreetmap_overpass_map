import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:overpass_map/overpass_json_parser.dart';

class OverpassApi {
  final String _baseUrl;

  OverpassApi({String baseUrl = 'https://overpass-api.de/api/interpreter'}) : _baseUrl = baseUrl;

  /// Single query to get all administrative boundaries for a city in one request
  Future<OverPassAPIResult> getCityData(String cityName, {int cityAdminLevel = 6}) async {
    // Single query that gets city (level 6), bezirke (level 9), and stadtteile (level 10)
    final query =
        '''
[out:json][timeout:60];
(
  // City level (e.g., Cologne at level 6)
  relation["boundary"="administrative"]["type"="boundary"]["admin_level"="$cityAdminLevel"]["name"="$cityName"];
  
  // Get the city area first, then find sub-districts within it
  relation["boundary"="administrative"]["type"="boundary"]["admin_level"="$cityAdminLevel"]["name"="$cityName"] -> .city;
  
  // Bezirke (level 9) within the city
  relation(area.city)["boundary"="administrative"]["type"="boundary"]["admin_level"="9"];
  
  // Stadtteile (level 10) within the city  
  relation(area.city)["boundary"="administrative"]["type"="boundary"]["admin_level"="10"];
);
out geom;
''';

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
