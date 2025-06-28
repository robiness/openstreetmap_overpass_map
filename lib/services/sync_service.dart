import 'package:drift/drift.dart';
import 'package:overpass_map/data/database/app_database.dart';
import 'package:overpass_map/services/api_client.dart';

/// A service responsible for synchronizing local data with the backend.
class SyncService {
  final AppDatabase _db;
  final IApiClient _apiClient;

  SyncService({
    required AppDatabase database,
    required IApiClient apiClient,
  }) : _db = database,
       _apiClient = apiClient;

  /// Finds all local records that have not yet been synced and uploads them
  /// to the backend.
  ///
  /// On a successful upload, the local records are updated with a new
  /// [synced_at] timestamp.
  Future<void> push() async {
    final unsyncedCheckIns = await (_db.select(
      _db.checkIns,
    )..where((tbl) => tbl.syncedAt.isNull())).get();

    if (unsyncedCheckIns.isEmpty) {
      return;
    }

    try {
      await _apiClient.upsertCheckIns(unsyncedCheckIns);

      final syncedIds = unsyncedCheckIns.map((c) => c.id).toList();
      final updateStatement = _db.update(_db.checkIns)
        ..where((tbl) => tbl.id.isIn(syncedIds));
      await updateStatement.write(
        CheckInsCompanion(
          syncedAt: Value(DateTime.now()),
        ),
      );
    } catch (e) {
      print('SyncService push error: $e');
    }
  }

  /// Fetches the latest records from the backend and updates the
  /// local database.
  Future<void> pull() async {
    try {
      // 1. Find the last sync time.
      final lastSync =
          await (_db.select(_db.checkIns)
                ..orderBy([
                  (t) => OrderingTerm(
                    expression: t.syncedAt,
                    mode: OrderingMode.desc,
                  ),
                ])
                ..where((t) => t.syncedAt.isNotNull())
                ..limit(1))
              .getSingleOrNull();

      // 2. Fetch latest records from the API.
      final remoteCheckIns = await _apiClient.fetchLatestCheckIns(
        since: lastSync?.syncedAt,
      );

      if (remoteCheckIns.isEmpty) {
        return;
      }

      // 3. Upsert records into the local database in a batch.
      final now = DateTime.now();
      await _db.batch((batch) {
        batch.insertAll(
          _db.checkIns,
          remoteCheckIns.map(
            (c) => CheckInsCompanion.insert(
              id: c.id,
              userId: c.userId,
              stadtteilId: c.stadtteilId,
              updatedAt: Value(c.updatedAt),
              syncedAt: Value(now),
            ),
          ),
          mode: InsertMode.insertOrReplace,
        );
      });
    } catch (e) {
      print('SyncService pull error: $e');
    }
  }
}
