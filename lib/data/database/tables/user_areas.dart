import 'package:drift/drift.dart';
import 'package:overpass_map/data/database/tables/areas.dart';

@DataClassName('UserArea')
class UserAreas extends Table {
  IntColumn get areaId => integer().references(Areas, #id)();
  TextColumn get userId => text()();

  IntColumn get totalSpots => integer()();
  IntColumn get visitedSpots => integer()();

  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {areaId, userId};
}
