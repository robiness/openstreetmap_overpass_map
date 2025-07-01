import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:overpass_map/data/repositories/map_repository.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
import 'package:overpass_map/features/map_explorer/data/sources/overpass_api_data_source.dart';

class SupabaseMapRepositoryImpl implements MapRepository {
  final SupabaseClient _supabaseClient;
  final OverpassApiDataSource
  _spotDataSource; // Still use Overpass for spots until we have spots in Supabase

  SupabaseMapRepositoryImpl({
    required SupabaseClient supabaseClient,
    OverpassApiDataSource? spotDataSource,
  }) : _supabaseClient = supabaseClient,
       _spotDataSource = spotDataSource ?? OverpassApiDataSource();

  @override
  Future<BoundaryData> getCityBoundaryData({
    required String cityName,
    int cityAdminLevel = 6,
  }) async {
    try {
      // First, find the city by name and admin level
      final cityResponse = await _supabaseClient
          .from('areas')
          .select('id, name, admin_level, coordinates')
          .eq('name', cityName)
          .eq('admin_level', cityAdminLevel)
          .limit(1);

      if (cityResponse.isEmpty) {
        throw Exception(
          'City "$cityName" not found with admin_level $cityAdminLevel',
        );
      }

      final cityData = cityResponse.first;
      final cityId = cityData['id'] as int;

      // Fetch all child areas (bezirke and stadtteile) for this city
      final childAreasResponse = await _supabaseClient
          .from('areas')
          .select('id, name, admin_level, coordinates, parent_id')
          .eq('parent_id', cityId)
          .order('admin_level');

      // Also fetch any grandchildren (stadtteile under bezirke)
      final childIds = childAreasResponse
          .map((area) => area['id'] as int)
          .toList();
      List<dynamic> grandChildAreasResponse = [];

      if (childIds.isNotEmpty) {
        grandChildAreasResponse = await _supabaseClient
            .from('areas')
            .select('id, name, admin_level, coordinates, parent_id')
            .inFilter('parent_id', childIds)
            .order('admin_level');
      }

      // Combine all areas
      final allAreas = [
        cityData,
        ...childAreasResponse,
        ...grandChildAreasResponse,
      ];

      // Convert to Overpass-like JSON format that BoundaryData expects
      final osmLikeJson = _convertToOsmFormat(allAreas);

      return BoundaryData(osmLikeJson);
    } catch (e) {
      throw Exception('Failed to load boundary data for $cityName: $e');
    }
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
    // For now, still use Overpass API for spots
    // TODO: Implement spots from Supabase once spot data is available
    return await _spotDataSource.getSpots(
      cityName: cityName,
      categories: categories,
    );
  }

  @override
  Future<List<AvailableCity>> getAvailableCities({
    int cityAdminLevel = 6,
  }) async {
    try {
      final response = await _supabaseClient
          .from('areas')
          .select('id, name, admin_level')
          .eq('admin_level', cityAdminLevel)
          .order('name');

      return response.map<AvailableCity>((city) {
        return AvailableCity(
          id: city['id'] as int,
          name: city['name'] as String,
          adminLevel: city['admin_level'] as int,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to load available cities: $e');
    }
  }

  /// Converts Supabase area data to OSM-like JSON format that BoundaryData can parse
  Map<String, dynamic> _convertToOsmFormat(List<dynamic> areas) {
    final elements = <Map<String, dynamic>>[];

    for (final area in areas) {
      final coordinatesJson = area['coordinates'] as String;
      final coordinates = jsonDecode(coordinatesJson) as List<dynamic>;

      // Convert coordinates to OSM member format
      final members = <Map<String, dynamic>>[];

      for (int i = 0; i < coordinates.length; i++) {
        final way = coordinates[i] as List<dynamic>;
        final geometry = way.map((point) {
          final pointList = point as List<dynamic>;
          return {
            'lon': pointList[0] as double,
            'lat': pointList[1] as double,
          };
        }).toList();

        members.add({
          'type': 'way',
          'ref': area['id'] * 1000 + i, // Generate unique way ID
          'role': 'outer', // Assume all ways are outer boundaries
          'geometry': geometry,
        });
      }

      elements.add({
        'type': 'relation',
        'id': area['id'],
        'tags': {
          'name': area['name'],
          'boundary': 'administrative',
          'admin_level': area['admin_level'].toString(),
          'type': 'boundary',
        },
        'members': members,
      });
    }

    return {
      'version': 0.6,
      'generator': 'Supabase to OSM converter',
      'elements': elements,
    };
  }
}
