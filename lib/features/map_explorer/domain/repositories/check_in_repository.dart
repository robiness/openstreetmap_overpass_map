import 'package:overpass_map/data/database/app_database.dart';

/// An abstract repository to handle data operations for user check-ins.
///
/// This class defines the contract that the rest of the application will use
/// to interact with check-in data, decoupling the UI and business logic
/// from the specific data source implementation (e.g., Drift, Supabase API).
abstract class CheckInRepository {
  /// Watches for all check-ins belonging to a specific user.
  ///
  /// The UI can listen to this stream to get live updates from the local
  /// database, ensuring a reactive and fast user experience.
  ///
  /// Returns a [Stream] of a list of [CheckIn] objects.
  Stream<List<CheckIn>> watchUserCheckIns(String userId);

  /// Watches for all check-ins for a specific spot and user.
  Stream<List<CheckIn>> watchUserCheckInsForSpot(String userId, int spotId);

  /// Stream that emits user IDs when area completion stats are updated.
  /// This allows MapBloc to refresh area data in real-time when check-ins change.
  Stream<String> get areaStatsUpdated;

  /// Creates a new check-in for the currently authenticated user.
  ///
  /// This operation will first write to the local database for an immediate
  /// offline-first experience and then queue a synchronization with the cloud.
  Future<void> createCheckIn({
    required int spotId,
    required String userId,
  });

  /// Deletes all check-ins for a specific spot for a given user.
  Future<void> deleteCheckInsForSpot({
    required int spotId,
    required String userId,
  });
}
