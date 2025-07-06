import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:overpass_map/data/database/tables/areas.dart';
import 'package:overpass_map/data/database/tables/check_ins.dart';
import 'package:overpass_map/data/database/tables/cities.dart';
import 'package:overpass_map/data/database/tables/spots.dart';
import 'package:overpass_map/data/database/tables/user_areas.dart';
import 'connection/stub.dart' if (dart.library.io) 'connection/native.dart';

part 'app_database.g.dart';

class ListStringConverter extends TypeConverter<List<String>, String> {
  const ListStringConverter();
  @override
  List<String> fromSql(String fromDb) {
    return (json.decode(fromDb) as List).cast<String>();
  }

  @override
  String toSql(List<String> value) {
    return json.encode(value);
  }
}

class MapDynamicConverter extends TypeConverter<Map<String, dynamic>, String> {
  const MapDynamicConverter();
  @override
  Map<String, dynamic> fromSql(String fromDb) {
    return json.decode(fromDb) as Map<String, dynamic>;
  }

  @override
  String toSql(Map<String, dynamic> value) {
    return json.encode(value);
  }
}

@DriftDatabase(tables: [CheckIns, Areas, UserAreas, Cities, Spots])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(connect());

  /// A secondary constructor for testing purposes.
  AppDatabase.forTesting(super.connection);

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Migration from v1 to v2: Change stadtteilId (String) to spotId (int)
          // Since we're changing the column type, we need to recreate the table
          await m.drop(checkIns);
          await m.createTable(checkIns);
        }
        if (from < 3) {
          await m.createTable(areas);
          await m.createTable(userAreas);
        }
        if (from < 4) {
          await m.createTable(cities);
          await m.createTable(spots);
          await m.addColumn(areas, areas.parentId);
        }
        if (from < 5) {
          // Migration to v5: Ensure parent_id column exists (recreate areas table if needed)
          await m.drop(areas);
          await m.createTable(areas);
        }
        if (from < 6) {
          // Migration to v6: Spot and CheckIn ID changes from int to String
          await m.drop(spots);
          await m.createTable(spots);
          await m.drop(checkIns);
          await m.createTable(checkIns);
        }
      },
    );
  }
}
