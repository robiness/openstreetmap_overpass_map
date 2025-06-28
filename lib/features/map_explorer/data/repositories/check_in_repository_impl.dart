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

  CheckInRepositoryImpl({
    required AppDatabase database,
    required Uuid uuid,
  }) : _db = database,
       _uuid = uuid;

  @override
  Stream<List<CheckIn>> watchUserCheckIns(String userId) {
    return (_db.select(
      _db.checkIns,
    )..where((tbl) => tbl.userId.equals(userId))).watch();
  }

  @override
  Future<void> createCheckIn({
    required String stadtteilId,
    required String userId,
  }) async {
    final newCheckIn = CheckInsCompanion(
      id: Value(_uuid.v4()),
      userId: Value(userId),
      stadtteilId: Value(stadtteilId),
    );

    await _db.into(_db.checkIns).insert(newCheckIn);
  }
}
