import 'package:drift/drift.dart' hide isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:overpass_map/data/database/app_database.dart';
import 'package:uuid/uuid.dart';

import '../../helpers/database_helper.dart';

void main() {
  late AppDatabase db;
  const uuid = Uuid();

  setUp(() {
    db = createTestDatabase();
  });

  tearDown(() async {
    await db.close();
  });

  group('CheckIns DAO', () {
    test('should insert a check-in and set a valid timestamp', () async {
      // Arrange
      final firstCheckInId = uuid.v4();
      await db
          .into(db.checkIns)
          .insert(
            CheckInsCompanion(
              id: Value(firstCheckInId),
              userId: const Value('test-user-1'),
              stadtteilId: const Value('test-stadtteil-1'),
            ),
          );
      final firstCheckIn = await (db.select(
        db.checkIns,
      )..where((tbl) => tbl.id.equals(firstCheckInId))).getSingle();

      // Act
      final secondCheckInId = uuid.v4();
      await db
          .into(db.checkIns)
          .insert(
            CheckInsCompanion(
              id: Value(secondCheckInId),
              userId: const Value('test-user-2'),
              stadtteilId: const Value('test-stadtteil-2'),
            ),
          );
      final secondCheckIn = await (db.select(
        db.checkIns,
      )..where((tbl) => tbl.id.equals(secondCheckInId))).getSingle();

      // Assert
      expect(
        secondCheckIn.updatedAt.isAfter(firstCheckIn.updatedAt) ||
            secondCheckIn.updatedAt.isAtSameMomentAs(firstCheckIn.updatedAt),
        isTrue,
      );
    });

    test('should update a check-in without changing updatedAt', () async {
      // Arrange
      final checkInId = uuid.v4();
      final updatedTime = DateTime(2024, 1, 2);

      final initialCheckIn = CheckInsCompanion(
        id: Value(checkInId),
        userId: const Value('test-user'),
        stadtteilId: const Value('test-stadtteil'),
      );
      await db.into(db.checkIns).insert(initialCheckIn);

      final insertedCheckIn = await (db.select(
        db.checkIns,
      )..where((tbl) => tbl.id.equals(checkInId))).getSingle();

      // Act
      final updateStatement = db.update(db.checkIns)
        ..where((tbl) => tbl.id.equals(checkInId));
      await updateStatement.write(
        CheckInsCompanion(
          syncedAt: Value(updatedTime),
        ),
      );

      final updatedCheckIn = await (db.select(
        db.checkIns,
      )..where((tbl) => tbl.id.equals(checkInId))).getSingle();

      // Assert
      expect(updatedCheckIn.syncedAt, isNotNull);
      expect(
        updatedCheckIn.updatedAt.isAtSameMomentAs(insertedCheckIn.updatedAt),
        isTrue,
        reason: 'updatedAt should not change on a sync update',
      );
    });
  });
}
