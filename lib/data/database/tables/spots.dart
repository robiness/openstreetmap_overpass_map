import 'package:drift/drift.dart';
import 'package:overpass_map/data/database/app_database.dart';

@DataClassName('SpotData')
class Spots extends Table {
  TextColumn get id => text()();
  IntColumn get osmId => integer()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  RealColumn get lat => real()();
  RealColumn get lon => real()();
  TextColumn get description => text().nullable()();
  TextColumn get tags => text().map(const ListStringConverter())();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get createdBy => text().nullable()();
  TextColumn get properties => text().map(const MapDynamicConverter())();
  TextColumn get parentAreaId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
