import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:overpass_map/features/location/domain/entities/location_data.dart';
import 'package:overpass_map/features/location/presentation/bloc/location_bloc.dart';
import 'package:overpass_map/features/debug/presentation/bloc/debug_bloc.dart';
import 'package:overpass_map/features/map_explorer/presentation/bloc/map_bloc.dart';
import 'package:overpass_map/features/map_explorer/domain/repositories/check_in_repository.dart';
import 'package:overpass_map/data/database/app_database.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_state.dart';

class DebugPanel extends StatelessWidget {
  const DebugPanel({super.key});

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
              'Debug Panel',
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
              BlocBuilder<DebugBloc, DebugState>(
                builder: (context, state) {
                  return ElevatedButton.icon(
                    onPressed: () {
                      context.read<DebugBloc>().add(
                        const DebugEvent.pickLocationToggled(),
                      );
                    },
                    icon: Icon(
                      state.isPickingLocation
                          ? Icons.cancel
                          : Icons.location_pin,
                    ),
                    label: Text(
                      state.isPickingLocation
                          ? 'Cancel Picking'
                          : 'Pick Location on Map',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: state.isPickingLocation
                          ? Colors.red
                          : Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => context.read<LocationBloc>().add(
                      const LocationEvent.setDebugLocation(location: null),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text(
                      'Clear Debug',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, authState) {
                      return ElevatedButton(
                        onPressed: () async {
                          final userId = authState.maybeWhen(
                            authenticated: (user, profile) => user.id,
                            orElse: () =>
                                'test-user', // fallback for unauthenticated
                          );
                          final checkIns = await context
                              .read<CheckInRepository>()
                              .watchUserCheckIns(userId)
                              .first;
                          print('=== DATABASE CONTENTS ===');
                          print('User ID: $userId');
                          print('Check-ins count: ${checkIns.length}');
                          for (final checkIn in checkIns) {
                            print(
                              'ID: ${checkIn.id}, SpotID: ${checkIn.spotId}, UserID: ${checkIn.userId}',
                            );
                          }
                          print('========================');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'Log DB',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const Text(
                'Check-In Controls',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(height: 8),
              BlocBuilder<MapBloc, MapState>(
                builder: (context, mapState) {
                  final selectedSpot = mapState.maybeWhen(
                    loadSuccess:
                        (
                          _,
                          __,
                          ___,
                          selectedSpot,
                          ____,
                          _____,
                        ) => selectedSpot,
                    orElse: () => null,
                  );

                  if (selectedSpot != null) {
                    // Spot is selected, build the button with a stream
                    return BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, authState) {
                        final userId = authState.maybeWhen(
                          authenticated: (user, profile) => user.id,
                          orElse: () =>
                              'test-user', // fallback for unauthenticated
                        );

                        return StreamBuilder<List<CheckIn>>(
                          stream: context
                              .read<CheckInRepository>()
                              .watchUserCheckInsForSpot(
                                userId,
                                selectedSpot.id,
                              ),
                          builder: (context, snapshot) {
                            final count = snapshot.data?.length ?? 0;
                            final isCheckedIn = count > 0;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selected Spot: ${selectedSpot.name} (ID: ${selectedSpot.id})',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Check-ins for this spot: $count'),
                                Text('User: $userId'),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    final event = isCheckedIn
                                        ? DebugEvent.checkOutRequested(
                                            spotId: selectedSpot.id,
                                            userId: userId,
                                          )
                                        : DebugEvent.checkInRequested(
                                            spotId: selectedSpot.id,
                                            userId: userId,
                                          );
                                    context.read<DebugBloc>().add(event);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isCheckedIn
                                        ? Colors.red
                                        : Colors.green,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Text(
                                    isCheckedIn ? 'Check Out' : 'Check In',
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  } else {
                    // No spot selected, show a disabled button
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select a spot to enable check-in.',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 8),
                        const ElevatedButton(
                          onPressed: null,
                          child: Text('Check In'),
                        ),
                      ],
                    );
                  }
                },
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
