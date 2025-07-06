import 'package:drift/drift.dart';

/// Defines the schema for the `areas` table in the local database.
@DataClassName('Area')
class Areas extends Table {
  /// Unique identifier for the area (e.g., from Supabase).
  TextColumn get id => text()();

  /// OSM relation ID for this area (e.g., a city boundary).
  IntColumn get osmId => integer().unique()();
  TextColumn get parentId => text().nullable().references(Areas, #id)();
  TextColumn get name => text()();
  TextColumn get type => text()();
  IntColumn get adminLevel => integer()();

  /// Stored as a JSON string.
  TextColumn get coordinates => text()();
}
