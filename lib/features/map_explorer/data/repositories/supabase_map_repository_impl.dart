import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/data/database/app_database.dart';
import 'package:overpass_map/data/repositories/map_repository.dart';
import 'package:overpass_map/features/map_explorer/data/models/boundary_data.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseMapRepositoryImpl implements MapRepository {
  final SupabaseClient _supabaseClient;
  final AppDatabase _db;

  SupabaseMapRepositoryImpl({
    required SupabaseClient supabaseClient,
    required AppDatabase db,
  }) : _supabaseClient = supabaseClient,
       _db = db;

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
      final childIds = childAreasResponse.map((area) => area['id'] as int).toList();
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
  Future<List<Spot>> getSpots() async {
    print('🔍 getSpots() called');

    // Fetch all spots from the local database
    final cachedSpots = await _db.select(_db.spots).get();
    print('📱 Found ${cachedSpots.length} cached spots in local database');

    if (cachedSpots.isNotEmpty) {
      print('✅ Using cached spots');
      return cachedSpots.map((s) => _mapSpotDataToEntity(s)).toList();
    }

    // If cache is empty or stale, fetch all spots from Supabase
    print('🌐 Fetching spots from Supabase...');
    try {
      final response = await _supabaseClient
          .from('spots')
          .select('*');

      print('📡 Supabase response: ${response?.length ?? 0} spots received');

      if (response == null || response.isEmpty) {
        print('❌ No spots received from Supabase');
        return [];
      }

      print('🔄 Converting ${response.length} spots from Supabase format...');
      final spots = <Spot>[];
      for (final json in response) {
        try {
          // Convert Supabase data directly to Spot object
          final spotData = Map<String, dynamic>.from(json);
          print('🔍 Available columns: ${spotData.keys.toList()}');

          // Extract coordinates
          final lat = spotData['lat'] as double?;
          final lon = spotData['lon'] as double?;

          // Get category directly as string
          final category = spotData['category'] as String? ?? 'unknown';

          // Create Spot object directly
          final spot = Spot(
            id: spotData['id'] as String,
            name: spotData['name'] as String? ?? 'Unknown',
            category: category,
            location: LatLng(lat ?? 0.0, lon ?? 0.0),
            description: spotData['description'] as String?,
            tags: [], // Default empty tags
            createdAt: DateTime.tryParse(spotData['created_at'] as String? ?? '') ?? DateTime.now(),
            createdBy: null,
            properties: {},
            parentAreaId: spotData['parent_area_id']?.toString(),
          );

          spots.add(spot);
          print('✅ Successfully converted spot: ${spotData['name']}');
        } catch (e) {
          print('❌ Error converting spot ${json['id']}: $e');
          // Continue with other spots instead of failing completely
        }
      }

      print('💾 Saving ${spots.length} spots to local database...');
      // Save fetched spots to the local database
      if (spots.isNotEmpty) {
        await _db.batch((batch) {
          batch.insertAll(
            _db.spots,
            spots.map((s) => _mapSpotEntityToData(s)),
            mode: InsertMode.insertOrReplace,
          );
        });
        print('✅ Successfully saved spots to local database');
      }

      print('🎯 Returning ${spots.length} spots');
      return spots;
    } catch (e) {
      print('❌ Failed to load spots from Supabase: $e');
      throw Exception('Failed to load spots: $e');
    }
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

  // Helper to map from Spot entity to Drift's SpotData
  SpotData _mapSpotEntityToData(Spot spot) {
    return SpotData(
      id: spot.id,
      name: spot.name,
      category: spot.category,
      lat: spot.location.latitude,
      lon: spot.location.longitude,
      description: spot.description,
      tags: spot.tags,
      createdAt: spot.createdAt,
      createdBy: spot.createdBy,
      properties: spot.properties,
      parentAreaId: spot.parentAreaId,
    );
  }

  // Helper to map from Drift's SpotData to Spot entity
  Spot _mapSpotDataToEntity(SpotData spotData) {
    return Spot(
      id: spotData.id,
      name: spotData.name,
      category: spotData.category,
      location: LatLng(spotData.lat, spotData.lon),
      description: spotData.description,
      tags: spotData.tags,
      createdAt: spotData.createdAt,
      createdBy: spotData.createdBy,
      properties: spotData.properties,
      parentAreaId: spotData.parentAreaId,
    );
  }
}
