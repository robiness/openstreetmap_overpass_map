import 'package:drift/drift.dart';
import 'package:overpass_map/data/database/tables/areas.dart';

@DataClassName('Spot')
class Spots extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  RealColumn get lat => real()();
  RealColumn get lon => real()();

  IntColumn get parentAreaId => integer().references(Areas, #id)();

  TextColumn get spotType => text()();
  TextColumn get status => text()();

  TextColumn get createdBy => text().nullable()();
  TextColumn get properties => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
