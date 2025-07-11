import 'package:overpass_map/data/database/app_database.dart';
import 'package:overpass_map/features/location/domain/entities/location_data.dart';
import 'package:overpass_map/features/map_explorer/domain/exceptions/check_in_exception.dart';
import 'package:latlong2/latlong.dart';

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
  Stream<List<CheckIn>> watchUserCheckInsForSpot(String userId, String spotId);

  /// Stream that emits user IDs when area completion stats are updated.
  /// This allows MapBloc to refresh area data in real-time when check-ins change.
  Stream<String> get areaStatsUpdated;

  /// Creates a new check-in for the currently authenticated user.
  ///
  /// This operation will first write to the local database for an immediate
  /// offline-first experience and then queue a synchronization with the cloud.
  Future<void> createCheckIn({
    required String spotId,
    required String userId,
  });

  /// Creates a new check-in with location validation.
  ///
  /// Validates that the user is within the required proximity to the spot
  /// before allowing the check-in. In debug mode, proximity validation is bypassed.
  ///
  /// Throws [CheckInException] if the user is too far from the spot or if
  /// location validation fails.
  Future<void> createCheckInWithLocation({
    required String spotId,
    required String userId,
    required LocationData userLocation,
    required LatLng spotLocation,
    bool isDebugMode = false,
  });

  /// Deletes all check-ins for a specific spot for a given user.
  Future<void> deleteCheckInsForSpot({
    required String spotId,
    required String userId,
  });

  /// Recalculates completion stats for all areas a user has checked into.
  Future<void> recalculateAllAreaStats(String userId);
}
