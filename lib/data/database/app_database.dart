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
  int get schemaVersion => 1;
}
