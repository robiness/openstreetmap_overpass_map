import 'models/osm_models.dart';

/// Parses Overpass/OSM JSON data and produces lists of GeographicArea objects for city, bezirk, and stadtteil boundaries.
class BoundaryData {
  final List<GeographicArea> cities = [];
  final List<GeographicArea> bezirke = [];
  final List<GeographicArea> stadtteile = [];

  /// Parses the provided Overpass JSON string.
  BoundaryData(Map<String, dynamic> json) {
    final List elements = json['elements'] ?? [];

    // Parse relations directly since geometry is embedded in members
    for (final element in elements) {
      if (element['type'] == 'relation') {
        final relation = OsmRelation.fromJson(element);
        final tags = relation.tags;

        if (tags['boundary'] == 'administrative' && tags.containsKey('admin_level')) {
          final int adminLevel = int.tryParse(tags['admin_level'].toString()) ?? 0;
          final String name = tags['name']?.toString() ?? 'Unknown';
          print('Processing relation ${relation.id}: $name, admin_level: $adminLevel');

          String type;
          if (adminLevel == 6) {
            type = 'city';
          } else if (adminLevel == 9) {
            type = 'bezirk';
          } else if (adminLevel == 10) {
            type = 'stadtteil';
          } else {
            print('Skipping admin_level $adminLevel for $name');
            continue; // Not a target admin level
          }

          // Extract geomet ry directly from relation members
          List<List<List<double>>> coordinates = [];
          final members = element['members'] as List? ?? [];

          for (final memberData in members) {
            if (memberData['type'] == 'way' && memberData['role'] == 'outer') {
              final geometry = memberData['geometry'] as List?;
              if (geometry != null && geometry.isNotEmpty) {
                final wayCoords = geometry.map<List<double>>((point) {
                  return [
                    (point['lon'] as num).toDouble(),
                    (point['lat'] as num).toDouble(),
                  ];
                }).toList();
                coordinates.add(wayCoords);
              }
            }
          }

          if (coordinates.isNotEmpty) {
            final area = GeographicArea(
              id: relation.id,
              name: name,
              type: type,
              adminLevel: adminLevel,
              coordinates: coordinates,
            );

            print('Created $type area: $name with ${coordinates.length} coordinate rings');

            if (type == 'city') {
              cities.add(area);
            } else if (type == 'bezirk') {
              bezirke.add(area);
            } else if (type == 'stadtteil') {
              stadtteile.add(area);
            }
          } else {
            print('No coordinates found for $name (${relation.id})');
          }
        }
      }
    }
  }
}
