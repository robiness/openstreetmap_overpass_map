import 'package:drift/drift.dart';
import 'package:overpass_map/data/database/app_database.dart';
import 'package:overpass_map/features/auth/domain/repositories/auth_repository.dart';
import 'package:overpass_map/features/map_explorer/domain/repositories/check_in_repository.dart';
import 'package:overpass_map/services/api_client.dart';

/// A service responsible for synchronizing local data with the backend.
class SyncService {
  final AppDatabase _db;
  final IApiClient _apiClient;
  final CheckInRepository _checkInRepository;
  final AuthRepository _authRepository;

  SyncService({
    required AppDatabase database,
    required IApiClient apiClient,
    required CheckInRepository checkInRepository,
    required AuthRepository authRepository,
  }) : _db = database,
       _apiClient = apiClient,
       _checkInRepository = checkInRepository,
       _authRepository = authRepository;

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
      // --- Reconciliation Step: Remove deleted spots ---
      // 1. Get all spot IDs from the remote server
      final remoteSpotIds = (await _apiClient.getAllSpotIds()).toSet();

      // 2. Get all spot IDs from the local database
      final localSpots = await _db.select(_db.spots).get();
      final localSpotIds = localSpots.map((s) => s.id).toSet();

      // 3. Find local spots that don't exist remotely
      final orphanedSpotIds = localSpotIds.difference(remoteSpotIds);

      // 4. Delete orphaned spots from the local database
      if (orphanedSpotIds.isNotEmpty) {
        await (_db.delete(
          _db.spots,
        )..where((s) => s.id.isIn(orphanedSpotIds))).go();
        print(
          '🧹 SyncService: Removed ${orphanedSpotIds.length} orphaned spots.',
        );
      }

      // --- Fetch Updates Step: Get new/modified check-ins ---
      // 5. Find the last sync time for check-ins.
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

      // 6. Fetch latest check-in records from the API.
      final remoteCheckIns = await _apiClient.fetchLatestCheckIns(
        since: lastSync?.syncedAt,
      );

      if (remoteCheckIns.isNotEmpty) {
        // 7. Upsert check-in records into the local database in a batch.
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
      }

      // 8. Recalculate all area stats to ensure consistency
      final currentUser = _authRepository.currentUser;
      if (currentUser != null) {
        await _checkInRepository.recalculateAllAreaStats(currentUser.id);
      }
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
