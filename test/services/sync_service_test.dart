import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:overpass_map/data/database/app_database.dart';
import 'package:overpass_map/services/api_client.dart';
import 'package:overpass_map/services/sync_service.dart';
import 'package:uuid/uuid.dart';

import '../helpers/database_helper.dart';

/// A fake implementation of our [IApiClient] for testing.
class FakeApiClient implements IApiClient {
  bool shouldSucceed;
  List<CheckIn> receivedCheckIns = [];
  List<String> receivedDeletedIds = [];
  List<CheckIn> checkInsToReturn = [];

  FakeApiClient({this.shouldSucceed = true});

  @override
  Future<void> upsertCheckIns(List<CheckIn> checkIns) async {
    receivedCheckIns = checkIns;
    if (shouldSucceed) {
      return Future.value();
    } else {
      throw Exception('Simulated API failure');
    }
  }

  @override
  Future<void> deleteCheckIns(List<String> checkInIds) async {
    receivedDeletedIds = checkInIds;
    if (shouldSucceed) {
      return Future.value();
    } else {
      throw Exception('Simulated API failure');
    }
  }

  @override
  Future<List<CheckIn>> fetchLatestCheckIns({DateTime? since}) async {
    if (shouldSucceed) {
      return Future.value(checkInsToReturn);
    } else {
      throw Exception('Simulated API failure');
    }
  }
}

void main() {
  late AppDatabase db;
  late FakeApiClient fakeApiClient;
  late SyncService syncService;
  const uuid = Uuid();

  setUp(() {
    db = createTestDatabase();
  });

  tearDown(() async {
    await db.close();
  });

  group('SyncService push()', () {
    test(
      'should find unsynced records, send them to the API, and update their synced_at on success',
      () async {
        // Arrange
        fakeApiClient = FakeApiClient(shouldSucceed: true);
        syncService = SyncService(
          database: db,
          apiClient: fakeApiClient,
          checkInRepositorientull,
          authRepository: null,
        );

        final checkInId = uuid.v4();
        final unsyncedCheckIn = CheckInsCompanion(
          id: Value(checkInId),
          userId: const Value('test-user'),
          spotId: const Value(1),
        );
        await db.into(db.checkIns).insert(unsyncedCheckIn);

        // Act
        await syncService.push();

        // Assert
        // 1. Verify that the API client received the correct data.
        expect(fakeApiClient.receivedCheckIns, hasLength(1));
        expect(fakeApiClient.receivedCheckIns.first.id, checkInId);

        // 2. Verify that the local record was updated.
        final syncedCheckIn = await (db.select(
          db.checkIns,
        )..where((tbl) => tbl.id.equals(checkInId))).getSingle();
        expect(syncedCheckIn.syncedAt, isNotNull);
      },
    );

    test('should NOT update synced_at on failed push', () async {
      // Arrange
      fakeApiClient = FakeApiClient(shouldSucceed: false);
      syncService = SyncService(database: db, apiClient: fakeApiClient);

      final checkInId = uuid.v4();
      final unsyncedCheckIn = CheckInsCompanion(
        id: Value(checkInId),
        userId: const Value('test-user'),
        spotId: const Value(1),
      );
      await db.into(db.checkIns).insert(unsyncedCheckIn);

      // Act
      await syncService.push();

      // Assert
      final stillUnsyncedCheckIn = await (db.select(
        db.checkIns,
      )..where((tbl) => tbl.id.equals(checkInId))).getSingle();
      expect(stillUnsyncedCheckIn.syncedAt, isNull);
    });

    test(
      'should sync deleted records and keep them as soft deletes locally',
      () async {
        // Arrange
        fakeApiClient = FakeApiClient(shouldSucceed: true);
        syncService = SyncService(database: db, apiClient: fakeApiClient);

        final checkInId = uuid.v4();
        final deletedCheckIn = CheckInsCompanion(
          id: Value(checkInId),
          userId: const Value('test-user'),
          spotId: const Value(1),
          deletedAt: Value(DateTime.now()),
          syncedAt: const Value(null), // Mark as unsynced
        );
        await db.into(db.checkIns).insert(deletedCheckIn);

        // Act
        await syncService.push();

        // Assert
        // 1. Verify that the API client received the deletion request
        expect(fakeApiClient.receivedDeletedIds, hasLength(1));
        expect(fakeApiClient.receivedDeletedIds.first, checkInId);

        // 2. Verify that the local record is kept as a soft delete with syncedAt set
        final localCheckIn = await (db.select(
          db.checkIns,
        )..where((tbl) => tbl.id.equals(checkInId))).getSingleOrNull();
        expect(localCheckIn, isNotNull);
        expect(localCheckIn!.deletedAt, isNotNull); // Still marked as deleted
        expect(localCheckIn.syncedAt, isNotNull); // Now marked as synced
      },
    );
  });

  group('SyncService pull()', () {
    test(
      'should fetch new records from the API and upsert them locally',
      () async {
        // Arrange
        final remoteCheckInId = uuid.v4();
        final remoteCheckIn = CheckIn(
          id: remoteCheckInId,
          userId: 'remote-user',
          spotId: 1,
          updatedAt: DateTime.now(),
        );

        fakeApiClient = FakeApiClient(shouldSucceed: true)..checkInsToReturn = [remoteCheckIn];
        syncService = SyncService(database: db, apiClient: fakeApiClient);

        // Act
        await syncService.pull();

        // Assert
        final localCheckIn = await (db.select(
          db.checkIns,
        )..where((tbl) => tbl.id.equals(remoteCheckInId))).getSingleOrNull();

        expect(localCheckIn, isNotNull);
        expect(localCheckIn!.id, remoteCheckInId);
        expect(localCheckIn.userId, 'remote-user');
      },
    );
  });
}
