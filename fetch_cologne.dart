import 'dart:convert';
import 'dart:io';

import 'package:overpass_map/overpass_api.dart';

Future<void> main() async {
  print('Starting Cologne data fetch...');

  final api = OverpassApi();

  print("Fetching Cologne administrative boundaries...");

  try {
    final response = await api.getCityData('Köln');

    // Save to cologne_response.json
    final file = File('lib/cologne_response.json');
    await file.writeAsString(jsonEncode(response.data!.rawJson));
    print("✅ Saved response to lib/cologne_response.json");
  } catch (e) {
    print('❌ Error fetching Cologne boundaries: $e');
    exit(1);
  }
}
