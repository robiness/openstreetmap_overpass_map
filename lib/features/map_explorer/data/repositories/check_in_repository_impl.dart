import 'dart:async';

import 'package:drift/drift.dart';
import 'package:overpass_map/data/database/app_database.dart';
import 'package:overpass_map/features/map_explorer/domain/repositories/check_in_repository.dart';
import 'package:uuid/uuid.dart';

/// The concrete implementation of the [CheckInRepository].
///
/// This class handles the actual data operations by interacting directly
/// with the local Drift [AppDatabase].
class CheckInRepositoryImpl implements CheckInRepository {
  final AppDatabase _db;
  final Uuid _uuid;
  final StreamController<String> _areaStatsController =
      StreamController<String>.broadcast();

  CheckInRepositoryImpl({
    required AppDatabase database,
    required Uuid uuid,
  }) : _db = database,
       _uuid = uuid;

  @override
  Stream<String> get areaStatsUpdated => _areaStatsController.stream;

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

    // Update area stats after check-in
    await _updateAreaStats(spotId, userId);
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

    // Update area stats after check-out
    await _updateAreaStats(spotId, userId);
  }

  @override
  Future<void> recalculateAllAreaStats(String userId) async {
    final allUserCheckIns = await (_db.select(
      _db.checkIns,
    )..where((c) => c.userId.equals(userId) & c.deletedAt.isNull())).get();

    final checkedInSpotIds = allUserCheckIns.map((c) => c.spotId).toSet();

    if (checkedInSpotIds.isEmpty) {
      return; // No spots to process
    }

    final spots = await (_db.select(
      _db.spots,
    )..where((s) => s.id.isIn(checkedInSpotIds))).get();

    final areaIdsToUpdate = spots.map((s) => s.parentAreaId).toSet();

    for (final areaId in areaIdsToUpdate) {
      // This is a bit inefficient, but it's the simplest way to reuse the
      // existing logic. We find one spot in the area and trigger the update.
      final spotInArea = spots.firstWhere((s) => s.parentAreaId == areaId);
      await _updateAreaStats(spotInArea.id, userId);
    }
  }

  /// Updates area completion stats for the area containing the given spot
  Future<void> _updateAreaStats(int spotId, String userId) async {
    try {
      // Get the spot and its parent area
      final spot = await (_db.select(
        _db.spots,
      )..where((s) => s.id.equals(spotId))).getSingleOrNull();

      if (spot == null) {
        print(
          '⚠️ Spot $spotId not found in database, skipping area stats update',
        );
        return;
      }

      final areaId = spot.parentAreaId;

      // Calculate total spots in this area
      final totalSpots =
          await (_db.select(
            _db.spots,
          )..where((s) => s.parentAreaId.equals(areaId))).get().then(
            (spots) => spots.length,
          );

      // Get all spots in this area
      final spotsInArea = await (_db.select(
        _db.spots,
      )..where((s) => s.parentAreaId.equals(areaId))).get();
      final spotIdsInArea = spotsInArea.map((s) => s.id).toSet();

      // Get all check-ins for this user
      final allUserCheckIns = await (_db.select(
        _db.checkIns,
      )..where((c) => c.userId.equals(userId) & c.deletedAt.isNull())).get();

      // Count unique spots that have been visited in this area
      final visitedSpotIds = allUserCheckIns
          .map((checkIn) => checkIn.spotId)
          .where((spotId) => spotIdsInArea.contains(spotId))
          .toSet();
      final visitedSpots = visitedSpotIds.length;

      // Determine completion timestamp
      final completedAt = (visitedSpots >= totalSpots && totalSpots > 0)
          ? DateTime.now()
          : null;

      // Update or insert UserArea record
      await _db
          .into(_db.userAreas)
          .insertOnConflictUpdate(
            UserAreasCompanion(
              areaId: Value(areaId),
              userId: Value(userId),
              totalSpots: Value(totalSpots),
              visitedSpots: Value(visitedSpots),
              completedAt: Value(completedAt),
            ),
          );

      print(
        '📊 Area stats updated: $areaId -> $visitedSpots/$totalSpots spots',
      );

      // Notify MapBloc that area stats have been updated
      _areaStatsController.add(userId);
      print('🔔 Area stats update notification sent for user $userId');
    } catch (e) {
      print('❌ Failed to update area stats: $e');
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
