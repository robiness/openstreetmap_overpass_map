import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../../domain/entities/location_data.dart';
import '../../domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationData? _debugLocation;
  StreamController<LocationData>? _debugLocationController;

  @override
  Future<bool> hasLocationPermission() async {
    // On web, permissions are handled automatically by the browser
    // checkPermission is unreliable and may always return denied
    if (kIsWeb) {
      return true;
    }

    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  @override
  Future<bool> requestLocationPermission() async {
    // On web, permissions are handled automatically by the browser
    // Just return true since getCurrentPosition will handle the permission dialog
    if (kIsWeb) {
      return true;
    }

    if (await hasLocationPermission()) return true;

    final permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    // On web, location services are always "enabled" if browser supports it
    if (kIsWeb) {
      return true;
    }

    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<LocationData?> getCurrentLocation() async {
    // Return debug location if set (in debug mode)
    if (kDebugMode && _debugLocation != null) {
      return _debugLocation;
    }

    try {
      if (!await isLocationServiceEnabled()) return null;
      if (!await hasLocationPermission()) return null;

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      return LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          position.timestamp?.millisecondsSinceEpoch ??
              DateTime.now().millisecondsSinceEpoch,
        ),
        isMocked: position.isMocked,
      );
    } catch (e) {
      debugPrint('Error getting current location: $e');
      return null;
    }
  }

  @override
  Stream<LocationData> getLocationStream() {
    // Return debug location stream if set (in debug mode)
    if (kDebugMode && _debugLocation != null) {
      _debugLocationController ??= StreamController<LocationData>.broadcast();

      // Emit the debug location periodically
      Timer.periodic(const Duration(seconds: 2), (timer) {
        if (_debugLocationController?.isClosed == false &&
            _debugLocation != null) {
          _debugLocationController?.add(_debugLocation!);
        }
      });

      return _debugLocationController!.stream;
    }

    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Only update if moved 10 meters
      ),
    ).map(
      (position) => LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          position.timestamp?.millisecondsSinceEpoch ??
              DateTime.now().millisecondsSinceEpoch,
        ),
        isMocked: position.isMocked,
      ),
    );
  }

  @override
  void setDebugLocation(LocationData? debugLocation) {
    if (kDebugMode) {
      _debugLocation = debugLocation;
      debugPrint(
        'Debug location set: ${debugLocation?.latitude}, ${debugLocation?.longitude}',
      );
    }
  }

  @override
  void clearDebugLocation() {
    if (kDebugMode) {
      _debugLocation = null;
      _debugLocationController?.close();
      _debugLocationController = null;
      debugPrint('Debug location cleared');
    }
  }
}
