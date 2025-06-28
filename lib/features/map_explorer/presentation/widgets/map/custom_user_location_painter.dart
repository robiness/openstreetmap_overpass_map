import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:overpass_map/features/location/domain/entities/location_data.dart';

/// A custom painter for drawing the user's current location on the map
class CustomUserLocationPainter extends CustomPainter {
  final LocationData location;
  final MapCamera camera;

  CustomUserLocationPainter({
    required this.location,
    required this.camera,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final userLatLng = LatLng(location.latitude, location.longitude);
    final screenPoint = camera.latLngToScreenOffset(userLatLng);

    // Don't draw if the user location is outside the visible area
    if (screenPoint.dx < -50 ||
        screenPoint.dx > size.width + 50 ||
        screenPoint.dy < -50 ||
        screenPoint.dy > size.height + 50) {
      return;
    }

    // Draw accuracy circle (if accuracy is reasonable)
    if (location.accuracy <= 200) {
      _drawAccuracyCircle(canvas, screenPoint, userLatLng);
    }

    // Draw the user location dot
    _drawUserLocationDot(canvas, screenPoint);
  }

  void _drawAccuracyCircle(
    Canvas canvas,
    Offset screenPoint,
    LatLng userLatLng,
  ) {
    // Calculate the radius in screen pixels for the accuracy circle
    // We need to convert meters to screen pixels based on current zoom level
    final accuracyInMeters = location.accuracy;

    // Create a point that's accuracy meters away from user location
    const distance = Distance();
    final northPoint = distance.offset(userLatLng, accuracyInMeters, 0);
    final northScreenPoint = camera.latLngToScreenOffset(northPoint);

    // Calculate radius in pixels
    final radiusInPixels = (northScreenPoint.dy - screenPoint.dy).abs();

    // Only draw if the radius is reasonable (not too small or too large)
    if (radiusInPixels >= 5 && radiusInPixels <= 1000) {
      // Draw accuracy circle with transparent fill
      final accuracyPaint = Paint()
        ..color = Colors.blue.withValues(alpha: 0.1)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(screenPoint, radiusInPixels, accuracyPaint);

      // Draw accuracy circle border
      final accuracyBorderPaint = Paint()
        ..color = Colors.blue.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      canvas.drawCircle(screenPoint, radiusInPixels, accuracyBorderPaint);
    }
  }

  void _drawUserLocationDot(Canvas canvas, Offset screenPoint) {
    const dotRadius = 8.0;
    const borderWidth = 3.0;

    // Draw white border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(screenPoint, dotRadius + borderWidth, borderPaint);

    // Draw blue location dot
    final dotPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(screenPoint, dotRadius, dotPaint);

    // Draw inner white dot for better visibility
    final innerDotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(screenPoint, dotRadius * 0.4, innerDotPaint);

    // Add a subtle pulsing effect ring for mock locations
    if (location.isMocked) {
      final mockIndicatorPaint = Paint()
        ..color = Colors.orange.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      canvas.drawCircle(
        screenPoint,
        dotRadius + borderWidth + 4,
        mockIndicatorPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomUserLocationPainter oldDelegate) {
    return oldDelegate.location != location || oldDelegate.camera != camera;
  }
}
