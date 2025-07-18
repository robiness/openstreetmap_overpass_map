import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/foundation.dart';

/// Obtains a database connection for the web using the modern WasmDatabase.
DatabaseConnection connect() {
  return DatabaseConnection.delayed(
    Future(() async {
      final db = await WasmDatabase.open(
        databaseName: 'app-db',
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.js'),
      );

      if (db.missingFeatures.isNotEmpty) {
        debugPrint('Unsupported features: ${db.missingFeatures}');
      }

      return db.resolvedExecutor;
    }),
  );
}
