import 'package:drift/native.dart';
import 'package:overpass_map/data/database/app_database.dart';

/// Creates an in-memory version of the [AppDatabase] for testing purposes.
///
/// This is useful for tests that need a clean, isolated database instance
/// without interacting with the file system.
AppDatabase createTestDatabase() {
  return AppDatabase.forTesting(NativeDatabase.memory());
}
