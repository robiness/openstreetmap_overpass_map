import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:overpass_map/data/database/app_database.dart';
import 'package:overpass_map/services/api_client.dart';

class SupabaseApiClient implements IApiClient {
  final SupabaseClient _client;

  SupabaseApiClient(this._client);

  @override
  Future<void> upsertCheckIns(List<CheckIn> checkIns) async {
    final checkInMaps = checkIns
        .map(
          (c) => {
            'id': c.id,
            'user_id': c.userId,
            'spot_id': c.spotId,
            'updated_at': c.updatedAt.toIso8601String(),
          },
        )
        .toList();

    await _client.from('check_ins').upsert(checkInMaps);
  }

  @override
  Future<void> deleteCheckIns(List<String> checkInIds) async {
    if (checkInIds.isEmpty) return;

    // Delete each check-in individually
    for (final id in checkInIds) {
      await _client.from('check_ins').delete().eq('id', id);
    }
  }

  @override
  Future<List<CheckIn>> fetchLatestCheckIns({DateTime? since}) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw 'User not authenticated';
    }

    var query = _client.from('check_ins').select().eq('user_id', userId);

    if (since != null) {
      query = query.gt('updated_at', since.toIso8601String());
    }

    final response = await query;
    final data = response as List<dynamic>;

    return data.map((map) {
      final json = map as Map<String, dynamic>;
      return CheckIn(
        id: json['id'],
        userId: json['user_id'],
        spotId: json['spot_id'],
        updatedAt: DateTime.parse(json['updated_at']),
        syncedAt: json['synced_at'] == null
            ? null
            : DateTime.tryParse(json['synced_at']),
      );
    }).toList();
  }
}
