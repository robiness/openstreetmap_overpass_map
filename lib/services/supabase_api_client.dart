import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:overpass_map/data/database/app_database.dart';
import 'package:overpass_map/services/api_client.dart';

class SupabaseApiClient implements IApiClient {
  final SupabaseClient _supabase;

  SupabaseApiClient(this._supabase);

  @override
  Future<void> upsertCheckIns(List<CheckIn> checkIns) async {
    final dataToUpsert = checkIns
        .map(
          (checkIn) => {
            'id': checkIn.id,
            'user_id': checkIn.userId,
            'stadtteil_id': checkIn.stadtteilId,
            'updated_at': checkIn.updatedAt.toIso8601String(),
          },
        )
        .toList();

    await _supabase.from('checkins').upsert(dataToUpsert);
  }

  @override
  Future<List<CheckIn>> fetchLatestCheckIns({DateTime? since}) async {
    final query = _supabase.from('checkins').select();

    if (since != null) {
      query.gt('updated_at', since.toIso8601String());
    }

    final response = await query;
    return response.map((map) => CheckIn.fromJson(map)).toList();
  }
}
