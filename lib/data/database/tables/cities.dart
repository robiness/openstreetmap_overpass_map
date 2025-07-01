import 'package:drift/drift.dart';

@DataClassName('City')
class Cities extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get overpassAreaId => integer()();
  TextColumn get hierarchyAdminLevels => text()(); // Stored as a JSON list
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
