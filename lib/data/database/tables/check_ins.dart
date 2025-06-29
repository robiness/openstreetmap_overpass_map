import 'package:drift/drift.dart';

/// The `CheckIns` table holds records of user visits to specific spots.
class CheckIns extends Table {
  /// A unique identifier for the check-in, typically a UUID.
  TextColumn get id => text()();

  /// The ID of the user who performed the check-in.
  TextColumn get userId => text()();

  /// The ID of the spot that was visited.
  IntColumn get spotId => integer()();

  /// The timestamp when this record was last modified locally.
  /// This is automatically set on creation.
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();

  /// The timestamp when this record was last successfully synced with the cloud.
  /// A `NULL` value indicates that this record has local changes that
  /// have not yet been pushed to the server.
  DateTimeColumn get syncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
