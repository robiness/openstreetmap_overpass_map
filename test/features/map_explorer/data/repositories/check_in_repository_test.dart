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
      'deleteCheckInsForSpot should remove all check-ins for a spot',
      () async {
        // Arrange
        await repository.createCheckIn(spotId: 1, userId: testUserId);
        await repository.createCheckIn(spotId: 1, userId: testUserId);
        await repository.createCheckIn(spotId: 2, userId: testUserId);

        // Act
        await repository.deleteCheckInsForSpot(spotId: 1, userId: testUserId);

        // Assert
        final remainingCheckIns = await (db.select(db.checkIns)).get();
        expect(remainingCheckIns.length, 1);
        expect(remainingCheckIns.first.spotId, 2);
      },
    );
  });
}
