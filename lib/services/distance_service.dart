import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/features/location/domain/entities/location_data.dart';

/// Service for calculating distances between geographic coordinates
class DistanceService {
  static const double _checkInRadiusMeters = 50.0;

  /// Calculates the distance in meters between two geographic points using the haversine formula
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }

  /// Calculates distance between a user location and a spot location
  static double calculateDistanceToSpot(
    LocationData userLocation,
    LatLng spotLocation,
  ) {
    return calculateDistance(
      userLocation.latitude,
      userLocation.longitude,
      spotLocation.latitude,
      spotLocation.longitude,
    );
  }

  /// Checks if the user is within the required check-in radius of a spot
  static bool isWithinCheckInRange(
    LocationData userLocation,
    LatLng spotLocation,
  ) {
    final distance = calculateDistanceToSpot(userLocation, spotLocation);
    return distance <= _checkInRadiusMeters;
  }

  /// Gets the required check-in radius in meters
  static double get checkInRadiusMeters => _checkInRadiusMeters;

  /// Formats distance for display purposes
  static String formatDistance(double distanceInMeters) {
    if (distanceInMeters < 1000) {
      return '${distanceInMeters.round()}m';
    } else {
      return '${(distanceInMeters / 1000).toStringAsFixed(1)}km';
    }
  }

  /// Calculates how far the user is from the check-in range
  static double calculateDistanceFromCheckInRange(
    LocationData userLocation,
    LatLng spotLocation,
  ) {
    final distance = calculateDistanceToSpot(userLocation, spotLocation);
    return distance - _checkInRadiusMeters;
  }
}