import 'package:drift/drift.dart';

@DataClassName('Area')
class Areas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer().nullable().references(Areas, #id)();
  TextColumn get name => text()();
  TextColumn get type => text()();
  IntColumn get adminLevel => integer()();

  /// Stored as a JSON string.
  TextColumn get coordinates => text()();
}
