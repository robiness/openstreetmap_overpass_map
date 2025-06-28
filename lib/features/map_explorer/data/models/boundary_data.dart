import 'package:overpass_map/features/map_explorer/data/models/osm_models.dart';

/// Parses Overpass/OSM JSON data and produces lists of GeographicArea objects for city, bezirk, and stadtteil boundaries.
class BoundaryData {
  final Map<String, dynamic> rawJson; // Store the raw JSON
  final List<GeographicArea> cities = [];
  final List<GeographicArea> bezirke = [];
  final List<GeographicArea> stadtteile = [];

  /// Parses the provided Overpass JSON string.
  BoundaryData(this.rawJson) {
    // Accept raw JSON in constructor
    final List elements = rawJson['elements'] ?? [];

    // Parse relations directly since geometry is embedded in members
    for (final element in elements) {
      if (element['type'] == 'relation') {
        final relation = OsmRelation.fromJson(element);
        final tags = relation.tags;

        if (tags['boundary'] == 'administrative' && tags.containsKey('admin_level')) {
          final int adminLevel = int.tryParse(tags['admin_level'].toString()) ?? 0;
          final String name = tags['name']?.toString() ?? 'Unknown';

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

          // Extract geometry from relation members and combine them properly
          List<List<List<double>>> coordinates = [];
          final members = element['members'] as List? ?? [];

          // Separate outer and inner ways
          List<List<List<double>>> outerWays = [];
          List<List<List<double>>> innerWays = [];

          for (final memberData in members) {
            if (memberData['type'] == 'way') {
              final geometry = memberData['geometry'] as List?;
              if (geometry != null && geometry.isNotEmpty) {
                final wayCoords = geometry.map<List<double>>((point) {
                  return [
                    (point['lon'] as num).toDouble(),
                    (point['lat'] as num).toDouble(),
                  ];
                }).toList();

                final role = memberData['role'] as String? ?? '';
                if (role == 'outer' || role == '') {
                  // Empty role often means outer boundary
                  outerWays.add(wayCoords);
                } else if (role == 'inner') {
                  innerWays.add(wayCoords);
                }
              }
            }
          }

          // Combine outer ways into continuous polygons
          if (outerWays.isNotEmpty) {
            final combinedOuters = _combineWays(outerWays);

            // Add combined outer ways
            coordinates.addAll(combinedOuters);

            // Add inner ways (holes) as separate rings
            if (innerWays.isNotEmpty) {
              coordinates.addAll(innerWays);
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

  /// Combines multiple ways into continuous polygons by connecting them end-to-end
  List<List<List<double>>> _combineWays(List<List<List<double>>> ways) {
    if (ways.isEmpty) return [];
    if (ways.length == 1) return ways;

    List<List<List<double>>> result = [];
    List<List<List<double>>> remaining = List.from(ways);

    while (remaining.isNotEmpty) {
      List<List<double>> currentPolygon = remaining.removeAt(0);
      bool foundConnection = true;

      // Keep trying to connect ways until no more connections are found
      while (foundConnection && remaining.isNotEmpty) {
        foundConnection = false;

        for (int i = 0; i < remaining.length; i++) {
          final way = remaining[i];

          // Check if this way connects to the end of current polygon
          if (_pointsEqual(currentPolygon.last, way.first)) {
            // Connect at the end, skip first point of way to avoid duplication
            currentPolygon.addAll(way.skip(1));
            remaining.removeAt(i);
            foundConnection = true;
            break;
          }
          // Check if this way connects to the start of current polygon
          else if (_pointsEqual(currentPolygon.first, way.last)) {
            // Connect at the start, skip last point of way to avoid duplication
            currentPolygon.insertAll(0, way.take(way.length - 1));
            remaining.removeAt(i);
            foundConnection = true;
            break;
          }
          // Check if this way connects reversed to the end
          else if (_pointsEqual(currentPolygon.last, way.last)) {
            // Connect reversed at the end, skip last point and reverse
            final reversedWay = way.reversed.toList();
            currentPolygon.addAll(reversedWay.skip(1));
            remaining.removeAt(i);
            foundConnection = true;
            break;
          }
          // Check if this way connects reversed to the start
          else if (_pointsEqual(currentPolygon.first, way.first)) {
            // Connect reversed at the start, skip first point and reverse
            final reversedWay = way.reversed.toList();
            currentPolygon.insertAll(
              0,
              reversedWay.take(reversedWay.length - 1),
            );
            remaining.removeAt(i);
            foundConnection = true;
            break;
          }
        }
      }
      result.add(currentPolygon);
    }
    return result;
  }

  /// Helper method to check if two coordinate points are equal (within a small tolerance)
  bool _pointsEqual(List<double> point1, List<double> point2) {
    const tolerance = 0.0000001; // Very small tolerance for floating point comparison
    return (point1[0] - point2[0]).abs() < tolerance && (point1[1] - point2[1]).abs() < tolerance;
  }
}
