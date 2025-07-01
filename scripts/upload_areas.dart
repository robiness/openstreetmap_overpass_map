import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:supabase/supabase.dart';

// IMPORTANT: Use environment variables for production.
const supabaseUrl = 'https://qltlkwnhhomfjdwosbhn.supabase.co';
// WARNING: This is a service role key. Do not expose it on the client side.
const supabaseServiceKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFsdGxrd25oaG9tZmpkd29zYmhuIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1MTEzNzc1MSwiZXhwIjoyMDY2NzEzNzUxfQ.RJo8Jsg3PXjW1UMV1FprhcNW7UeXGNs0PW93F9_BCMU';

const localFilePath = 'lib/cologne_response.json';

Future<void> main() async {
  final supabase = SupabaseClient(supabaseUrl, supabaseServiceKey);
  print('Connected to Supabase');

  try {
    final fileContent = await File(localFilePath).readAsString();
    final rawJson = jsonDecode(fileContent) as Map<String, dynamic>;
    await processLocalData(supabase, rawJson);
  } catch (e) {
    print('❌ An error occurred: $e');
  } finally {
    await supabase.dispose();
    print('Process finished.');
  }
}

Future<void> processLocalData(
  SupabaseClient supabase,
  Map<String, dynamic> rawJson,
) async {
  print('--- Processing data using IMPROVED HIERARCHICAL method ---');

  final elements = rawJson['elements'] as List<dynamic>;
  final areasByLevel = <int, List<Map<String, dynamic>>>{};
  final adminLevels = <int>{};

  for (final element in elements) {
    if (element['type'] == 'relation' &&
        element['tags']?['admin_level'] != null) {
      final int adminLevel = int.parse(element['tags']['admin_level']);
      adminLevels.add(adminLevel);
      areasByLevel.putIfAbsent(adminLevel, () => []).add(element);
    }
  }

  final sortedLevels = adminLevels.toList()..sort();
  print('Found admin levels: $sortedLevels');

  final allAreas = <Map<String, dynamic>>[];

  // Process each admin level in order, establishing parent-child relationships
  for (int levelIndex = 0; levelIndex < sortedLevels.length; levelIndex++) {
    final currentLevel = sortedLevels[levelIndex];
    final currentAreas = areasByLevel[currentLevel]!;

    print(
      'Processing ${currentAreas.length} areas at admin_level $currentLevel',
    );

    if (levelIndex == 0) {
      // First level (city) - no parent
      for (final area in currentAreas) {
        final parsedArea = _parseArea(area);
        if (parsedArea != null) {
          allAreas.add(parsedArea);
        }
      }
    } else {
      // Child levels - find parent from previous level
      final parentLevel = sortedLevels[levelIndex - 1];
      final parentAreas = areasByLevel[parentLevel]!;

      // Create lookup map of parent geometries
      final parentGeometries = <Map<String, dynamic>>[];
      for (final parentArea in parentAreas) {
        final ways = _extractCoordinateWays(parentArea);
        if (ways.isNotEmpty) {
          parentGeometries.add({
            'id': parentArea['id'],
            'name': parentArea['tags']['name'],
            'ways': ways,
          });
        }
      }

      int foundParents = 0;
      for (final childArea in currentAreas) {
        int? parentId;

        // Calculate centroid of child area
        final childWays = _extractCoordinateWays(childArea);
        final childCentroid = _calculateCentroid(childWays);

        if (childCentroid != null) {
          // Check which parent contains this centroid
          for (final parentGeom in parentGeometries) {
            if (_isPointInPolygon(
              childCentroid,
              parentGeom['ways'] as List<List<List<double>>>,
            )) {
              parentId = parentGeom['id'] as int;
              foundParents++;
              break;
            }
          }
        }

        // If geometric approach failed, try a simple bounding box approach
        if (parentId == null && childCentroid != null) {
          parentId = _findParentByBoundingBox(childCentroid, parentGeometries);
          if (parentId != null) {
            foundParents++;
            print(
              'Found parent using bounding box for ${childArea['tags']['name']}',
            );
          }
        }

        if (parentId == null) {
          final childName = childArea['tags']['name'] ?? 'Unknown';
          print(
            '⚠️ Could not find parent for $childName (${childArea['id']}) at level $currentLevel',
          );
        }

        final parsedArea = _parseArea(childArea, parentId: parentId);
        if (parsedArea != null) {
          allAreas.add(parsedArea);
        }
      }

      print(
        '✅ Found parents for $foundParents/${currentAreas.length} areas at level $currentLevel',
      );
    }
  }

  if (allAreas.isNotEmpty) {
    print('Clearing existing area data...');
    await supabase.from('areas').delete().neq('id', -1);
    print('Uploading ${allAreas.length} areas to Supabase...');
    await supabase.from('areas').upsert(allAreas);
    print('✅ Successfully uploaded all areas.');
  } else {
    print('No areas found to upload.');
  }
}

/// Fallback method using bounding box containment
int? _findParentByBoundingBox(
  List<double> point,
  List<Map<String, dynamic>> parentGeometries,
) {
  final px = point[0];
  final py = point[1];

  for (final parentGeom in parentGeometries) {
    final ways = parentGeom['ways'] as List<List<List<double>>>;

    // Calculate bounding box of parent
    double minLon = double.infinity;
    double maxLon = double.negativeInfinity;
    double minLat = double.infinity;
    double maxLat = double.negativeInfinity;

    for (final way in ways) {
      for (final coord in way) {
        minLon = math.min(minLon, coord[0]);
        maxLon = math.max(maxLon, coord[0]);
        minLat = math.min(minLat, coord[1]);
        maxLat = math.max(maxLat, coord[1]);
      }
    }

    // Check if point is within bounding box (with small margin)
    const margin = 0.001; // Small margin for floating point precision
    if (px >= minLon - margin &&
        px <= maxLon + margin &&
        py >= minLat - margin &&
        py <= maxLat + margin) {
      return parentGeom['id'] as int;
    }
  }

  return null;
}

Map<String, dynamic>? _parseArea(
  Map<String, dynamic> element, {
  int? parentId,
}) {
  final tags = element['tags'] as Map<String, dynamic>;
  final int id = element['id'];
  final String? name = tags['name'];
  final String? adminLevelStr = tags['admin_level'];

  if (name != null && adminLevelStr != null) {
    return {
      'id': id,
      'name': name,
      'type': tags['type'] ?? 'administrative',
      'admin_level': int.parse(adminLevelStr),
      'coordinates': jsonEncode(_extractCoordinateWays(element)),
      'parent_id': parentId,
    };
  }
  return null;
}

List<List<List<double>>> _extractCoordinateWays(Map<String, dynamic> relation) {
  final ways = <List<List<double>>>[];
  final members = relation['members'] as List? ?? [];
  for (final member in members) {
    if (member['type'] == 'way' && member['geometry'] != null) {
      final role = member['role'] as String? ?? '';
      if (role == 'outer' || role == '') {
        ways.add(
          (member['geometry'] as List)
              .map<List<double>>(
                (p) => [
                  (p['lon'] as num).toDouble(),
                  (p['lat'] as num).toDouble(),
                ],
              )
              .toList(),
        );
      }
    }
  }
  return ways;
}

List<double>? _calculateCentroid(List<List<List<double>>> ways) {
  if (ways.isEmpty) return null;
  double x = 0.0, y = 0.0;
  int pointCount = 0;
  for (final way in ways) {
    for (final point in way) {
      x += point[0];
      y += point[1];
      pointCount++;
    }
  }
  return pointCount > 0 ? [x / pointCount, y / pointCount] : null;
}

bool _isPointInPolygon(List<double> point, List<List<List<double>>> ways) {
  bool isInside = false;
  final double px = point[0];
  final double py = point[1];

  for (final way in ways) {
    for (int i = 0, j = way.length - 1; i < way.length; j = i++) {
      final double vix = way[i][0];
      final double viy = way[i][1];
      final double vjx = way[j][0];
      final double vjy = way[j][1];

      if (((viy > py) != (vjy > py)) &&
          (px < (vjx - vix) * (py - viy) / (vjy - viy) + vix)) {
        isInside = !isInside;
      }
    }
  }
  return isInside;
}
