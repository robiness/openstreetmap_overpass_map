import 'package:drift/drift.dart';
import 'package:overpass_map/data/database/tables/areas.dart';

/// Tracks user-specific progress within a geographic area (e.g., a city).
@DataClassName('UserArea')
class UserAreas extends Table {
  /// Foreign key to the `areas` table.
  TextColumn get areaId => text().references(Areas, #id)();

  /// Foreign key to a user ID (from Supabase Auth).
  TextColumn get userId => text()();

  IntColumn get totalSpots => integer()();
  IntColumn get visitedSpots => integer()();

  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {areaId, userId};
}
