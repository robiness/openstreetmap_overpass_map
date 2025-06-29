import 'package:drift/drift.dart';
import 'package:overpass_map/data/database/app_database.dart';
import 'package:overpass_map/features/map_explorer/domain/repositories/check_in_repository.dart';
import 'package:overpass_map/services/sync_service.dart';
import 'package:uuid/uuid.dart';

/// The concrete implementation of the [CheckInRepository].
///
/// This class handles the actual data operations by interacting directly
/// with the local Drift [AppDatabase].
class CheckInRepositoryImpl implements CheckInRepository {
  final AppDatabase _db;
  final Uuid _uuid;
  final SyncService? _syncService;

  CheckInRepositoryImpl({
    required AppDatabase database,
    required Uuid uuid,
    SyncService? syncService,
  }) : _db = database,
       _uuid = uuid,
       _syncService = syncService;

  @override
  Stream<List<CheckIn>> watchUserCheckIns(String userId) {
    return (_db.select(
          _db.checkIns,
        )..where((tbl) => tbl.userId.equals(userId) & tbl.deletedAt.isNull()))
        .watch();
  }

  @override
  Stream<List<CheckIn>> watchUserCheckInsForSpot(String userId, int spotId) {
    return (_db.select(_db.checkIns)
          ..where((tbl) => tbl.userId.equals(userId))
          ..where((tbl) => tbl.spotId.equals(spotId))
          ..where((tbl) => tbl.deletedAt.isNull()))
        .watch();
  }

  @override
  Future<void> createCheckIn({
    required int spotId,
    required String userId,
  }) async {
    final newCheckIn = CheckInsCompanion(
      id: Value(_uuid.v4()),
      userId: Value(userId),
      spotId: Value(spotId),
    );

    await _db.into(_db.checkIns).insert(newCheckIn);

    // Trigger sync to Supabase
    try {
      await _syncService?.push();
      print('✅ Check-in synced to Supabase');
    } catch (e) {
      print('❌ Failed to sync check-in to Supabase: $e');
    }
  }

  @override
  Future<void> deleteCheckInsForSpot({
    required int spotId,
    required String userId,
  }) async {
    // Soft delete: mark as deleted instead of hard deleting
    final updateStatement = _db.update(_db.checkIns)
      ..where(
        (tbl) =>
            tbl.spotId.equals(spotId) &
            tbl.userId.equals(userId) &
            tbl.deletedAt.isNull(), // Only update non-deleted records
      );

    await updateStatement.write(
      CheckInsCompanion(
        deletedAt: Value(DateTime.now()),
        syncedAt: const Value(null), // Mark as unsynced for push
        updatedAt: Value(DateTime.now()), // Update the modification time
      ),
    );

    // Trigger sync to Supabase (this will sync the deletion)
    try {
      await _syncService?.push();
      print('✅ Check-out synced to Supabase');
    } catch (e) {
      print('❌ Failed to sync check-out to Supabase: $e');
    }
  }

  /// Utility method to get all records (including soft-deleted ones) for debugging/audit
  Future<List<CheckIn>> getAllRecordsIncludingDeleted(String userId) async {
    return await (_db.select(_db.checkIns)
          ..where((tbl) => tbl.userId.equals(userId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.updatedAt)]))
        .get();
  }

  /// Utility method to get only soft-deleted records for debugging/audit
  Future<List<CheckIn>> getSoftDeletedRecords(String userId) async {
    return await (_db.select(_db.checkIns)
          ..where(
            (tbl) => tbl.userId.equals(userId) & tbl.deletedAt.isNotNull(),
          )
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.deletedAt)]))
        .get();
  }
}
