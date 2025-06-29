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
    // 1. Handle upserts (new/modified records)
    final unsyncedCheckIns = await (_db.select(
      _db.checkIns,
    )..where((tbl) => tbl.syncedAt.isNull() & tbl.deletedAt.isNull())).get();

    if (unsyncedCheckIns.isNotEmpty) {
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
        print('SyncService push (upserts) error: $e');
      }
    }

    // 2. Handle deletions (deleted records that need to be synced)
    final deletedCheckIns = await (_db.select(
      _db.checkIns,
    )..where((tbl) => tbl.deletedAt.isNotNull() & tbl.syncedAt.isNull())).get();

    if (deletedCheckIns.isNotEmpty) {
      try {
        final deletedIds = deletedCheckIns.map((c) => c.id).toList();
        await _apiClient.deleteCheckIns(deletedIds);

        // Mark deleted records as synced but keep them in local database (soft delete)
        final updateStatement = _db.update(_db.checkIns)
          ..where((tbl) => tbl.id.isIn(deletedIds));
        await updateStatement.write(
          CheckInsCompanion(
            syncedAt: Value(DateTime.now()),
          ),
        );

        print(
          '✅ ${deletedIds.length} deleted check-ins synced to Supabase (kept as soft deletes locally)',
        );
      } catch (e) {
        print('SyncService push (deletions) error: $e');

        // Mark as synced even if deletion failed, to avoid endless retry
        // (The record might already be deleted on the server)
        final syncedIds = deletedCheckIns.map((c) => c.id).toList();
        final updateStatement = _db.update(_db.checkIns)
          ..where((tbl) => tbl.id.isIn(syncedIds));
        await updateStatement.write(
          CheckInsCompanion(
            syncedAt: Value(DateTime.now()),
          ),
        );
      }
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
              spotId: c.spotId,
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

  /// Permanently removes soft-deleted records that are older than the specified duration
  /// and have been successfully synced to the backend.
  ///
  /// This helps prevent the local database from growing too large over time.
  /// Only call this periodically, not on every sync.
  Future<void> cleanupOldDeletedRecords({
    Duration olderThan = const Duration(days: 30),
  }) async {
    try {
      final cutoffDate = DateTime.now().subtract(olderThan);

      final deleteStatement = _db.delete(_db.checkIns)
        ..where(
          (tbl) =>
              tbl.deletedAt.isNotNull() &
              tbl.syncedAt.isNotNull() &
              tbl.deletedAt.isSmallerThanValue(cutoffDate),
        );

      final deletedCount = await deleteStatement.go();

      if (deletedCount > 0) {
        print('🧹 Cleaned up $deletedCount old soft-deleted records');
      }
    } catch (e) {
      print('SyncService cleanup error: $e');
    }
  }
}
