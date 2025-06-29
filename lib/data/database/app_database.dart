import 'package:drift/drift.dart';
import 'package:overpass_map/data/database/tables/check_ins.dart';
import 'connection/stub.dart' if (dart.library.io) 'connection/native.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [CheckIns])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(connect());

  /// A secondary constructor for testing purposes.
  AppDatabase.forTesting(super.connection);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Migration from v1 to v2: Change stadtteilId (String) to spotId (int)
          // Since we're changing the column type, we need to recreate the table
          await m.drop(checkIns);
          await m.createTable(checkIns);
        }
      },
    );
  }
}
