import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/location_data.dart';
import '../bloc/location_bloc.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Location Service',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Text('Location not requested yet'),
                  loading: () => const Row(
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 8),
                      Text('Getting location...'),
                    ],
                  ),
                  permissionGranted: () => const Text(
                    'Permission granted! You can now get location.',
                    style: TextStyle(color: Colors.green),
                  ),
                  permissionDenied: () => const Text(
                    'Location permission denied. Please enable it in settings.',
                    style: TextStyle(color: Colors.red),
                  ),
                  locationReceived: (location) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current Location:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('Latitude: ${location.latitude.toStringAsFixed(6)}'),
                      Text(
                        'Longitude: ${location.longitude.toStringAsFixed(6)}',
                      ),
                      Text(
                        'Accuracy: ${location.accuracy.toStringAsFixed(1)}m',
                      ),
                      Text(
                        'Time: ${location.timestamp.toString().substring(0, 19)}',
                      ),
                      if (location.isMocked)
                        const Text(
                          'Mock location detected',
                          style: TextStyle(color: Colors.orange),
                        ),
                    ],
                  ),
                  error: (message) => Text(
                    'Error: $message',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => context.read<LocationBloc>().add(
                    const LocationEvent.requestPermission(),
                  ),
                  child: const Text('Request Permission'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => context.read<LocationBloc>().add(
                    const LocationEvent.getCurrentLocation(),
                  ),
                  child: const Text('Get Location'),
                ),
              ],
            ),
            if (kDebugMode) ...[
              const SizedBox(height: 16),
              const Divider(),
              const Text(
                'Debug Mode',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _setDebugLocation(context, 'Cologne'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Set Cologne',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _setDebugLocation(context, 'Berlin'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Set Berlin',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => context.read<LocationBloc>().add(
                  const LocationEvent.setDebugLocation(location: null),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                child: const Text(
                  'Clear Debug',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _setDebugLocation(BuildContext context, String city) {
    LocationData debugLocation;

    switch (city) {
      case 'Cologne':
        debugLocation = LocationData(
          latitude: 50.9375,
          longitude: 6.9603,
          accuracy: 5.0,
          timestamp: DateTime.now(),
          isMocked: true,
        );
        break;
      case 'Berlin':
        debugLocation = LocationData(
          latitude: 52.5200,
          longitude: 13.4050,
          accuracy: 5.0,
          timestamp: DateTime.now(),
          isMocked: true,
        );
        break;
      default:
        return;
    }

    context.read<LocationBloc>().add(
      LocationEvent.setDebugLocation(location: debugLocation),
    );
  }
}
