import 'package:flutter_test/flutter_test.dart';
import 'package:overpass_map/data/database/app_database.dart';
import 'package:overpass_map/features/map_explorer/data/repositories/check_in_repository_impl.dart';
import 'package:overpass_map/features/map_explorer/domain/repositories/check_in_repository.dart';
import 'package:uuid/uuid.dart';

import '../../../../helpers/database_helper.dart';

void main() {
  late AppDatabase db;
  late CheckInRepository repository;
  const uuid = Uuid();
  const testUserId = 'test-user-id';

  setUp(() {
    db = createTestDatabase();
    repository = CheckInRepositoryImpl(database: db, uuid: uuid);
  });

  tearDown(() async {
    await db.close();
  });

  group('CheckInRepository', () {
    test(
      'createCheckIn should add a new record to the database with a null synced_at',
      () async {
        // Act
        await repository.createCheckIn(
          spotId: 123,
          userId: testUserId,
        );

        // Assert
        final checkIn = await (db.select(db.checkIns)).getSingle();
        expect(checkIn.userId, testUserId);
        expect(checkIn.spotId, 123);
        expect(checkIn.syncedAt, isNull);
        expect(checkIn.updatedAt, isNotNull);
      },
    );

    test(
      'watchUserCheckIns should emit a new list when a check-in is added',
      () async {
        // Arrange
        // Start listening to the stream before any action is taken.
        final expectation = expectLater(
          repository.watchUserCheckIns(testUserId),
          emitsInOrder([
            isEmpty, // The stream should first emit an empty list.
            isA<List<CheckIn>>().having((list) => list.length, 'length', 1),
          ]),
        );

        // Act: Add a small delay to ensure the stream listener is active
        // before we modify the database.
        await Future.delayed(const Duration(milliseconds: 10));
        await repository.createCheckIn(
          spotId: 123,
          userId: testUserId,
        );

        // Assert
        await expectation;
      },
    );

    test(
      'deleteCheckInsForSpot should soft delete check-ins for a spot',
      () async {
        // Arrange
        await repository.createCheckIn(spotId: 1, userId: testUserId);
        await repository.createCheckIn(spotId: 1, userId: testUserId);
        await repository.createCheckIn(spotId: 2, userId: testUserId);

        // Act
        await repository.deleteCheckInsForSpot(spotId: 1, userId: testUserId);

        // Assert
        // 1. All records should still exist in the database (soft delete)
        final allCheckIns = await (db.select(db.checkIns)).get();
        expect(allCheckIns.length, 3);

        // 2. Records for spot 1 should be marked as deleted
        final spot1CheckIns = allCheckIns.where((c) => c.spotId == 1).toList();
        expect(spot1CheckIns.length, 2);
        for (final checkIn in spot1CheckIns) {
          expect(checkIn.deletedAt, isNotNull);
          expect(checkIn.syncedAt, isNull); // Should be marked as unsynced
        }

        // 3. Record for spot 2 should NOT be marked as deleted
        final spot2CheckIns = allCheckIns.where((c) => c.spotId == 2).toList();
        expect(spot2CheckIns.length, 1);
        expect(spot2CheckIns.first.deletedAt, isNull);

        // 4. The repository watch method should only return non-deleted records
        final activeCheckIns = await repository
            .watchUserCheckIns(testUserId)
            .first;
        expect(activeCheckIns.length, 1);
        expect(activeCheckIns.first.spotId, 2);
      },
    );
  });
}
