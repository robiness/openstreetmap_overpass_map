import '../entities/location_data.dart';

abstract class LocationRepository {
  /// Check if location permissions are granted
  Future<bool> hasLocationPermission();

  /// Request location permissions
  Future<bool> requestLocationPermission();

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled();

  /// Get current location once
  Future<LocationData?> getCurrentLocation();

  /// Get location updates stream
  Stream<LocationData> getLocationStream();

  /// Override location for testing/debug mode
  void setDebugLocation(LocationData? debugLocation);

  /// Clear debug location override
  void clearDebugLocation();
}
