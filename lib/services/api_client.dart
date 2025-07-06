import 'package:overpass_map/data/database/app_database.dart';

/// An abstract interface for a generic API client.
///
/// This decouples the application from the specific implementation of the
/// backend client (e.g., Supabase), making it easier to test and swap
/// implementations in the future.
abstract class IApiClient {
  /// Upserts a list of check-in records to the backend.
  Future<void> upsertCheckIns(List<CheckIn> checkIns);

  /// Deletes a list of check-in records from the backend by their IDs.
  Future<void> deleteCheckIns(List<String> checkInIds);

  /// Fetches check-in records from the backend that have been updated since
  /// the given timestamp.
  ///
  /// If [since] is null, it should fetch all records.
  Future<List<CheckIn>> fetchLatestCheckIns({DateTime? since});

  /// Fetches a complete list of all existing spot IDs from the server.
  /// This is used to reconcile local data and remove deleted spots.
  Future<List<String>> getAllSpotIds();
}
