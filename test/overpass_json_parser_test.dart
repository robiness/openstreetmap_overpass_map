import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:overpass_map/overpass_json_parser.dart';

void main() {
  group('OverpassJsonParser', () {
    late String jsonString;

    setUpAll(() async {
      // Load the actual cologne_response.json file
      final file = File('lib/cologne_response.json');
      jsonString = await file.readAsString();
    });

    test('parses city, bezirke, and stadtteile from cologne_response.json', () {
      final parser = BoundaryData(jsonDecode(jsonString));

      // Debug output
      print('Cities found: ${parser.cities.length}');
      print('Bezirke found: ${parser.bezirke.length}');
      print('Stadtteile found: ${parser.stadtteile.length}');

      // Based on our Cologne query, we expect:
      // - At least 1 city (Köln at admin_level 6)
      // - Multiple bezirke (admin_level 9)
      // - Multiple stadtteile (admin_level 10)
      expect(parser.cities.length, greaterThan(0), reason: 'Should find Köln (admin_level 6)');
      expect(parser.bezirke.length, greaterThan(0), reason: 'Should parse bezirke (admin_level 9)');
      expect(parser.stadtteile.length, greaterThan(0), reason: 'Should parse stadtteile (admin_level 10)');
      // Check that each area has valid coordinates and names
      for (final area in [...parser.cities, ...parser.bezirke, ...parser.stadtteile]) {
        expect(area.name.isNotEmpty, true, reason: 'Area should have a name');
        expect(area.coordinates.isNotEmpty, true, reason: 'Area should have coordinates');
        for (final path in area.coordinates) {
          expect(path.isNotEmpty, true, reason: 'Each path should have points');
          for (final point in path) {
            expect(point.length, 2, reason: 'Each point should be [lon, lat]');
          }
        }
      }
    });
  });
}
