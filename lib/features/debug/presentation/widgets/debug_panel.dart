import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/app/theme/app_theme.dart';
import 'package:overpass_map/data/database/app_database.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_state.dart';
import 'package:overpass_map/features/debug/presentation/bloc/debug_bloc.dart';
import 'package:overpass_map/features/debug/presentation/widgets/theme_picker_button.dart';
import 'package:overpass_map/features/location/presentation/bloc/location_bloc.dart';
import 'package:overpass_map/features/map_explorer/domain/repositories/check_in_repository.dart';
import 'package:overpass_map/features/map_explorer/presentation/bloc/map_bloc.dart';

/// A unified debug panel view that can be used in both mobile and desktop layouts
/// This contains all the debug functionality in a scrollable container
class DebugPanelView extends StatelessWidget {
  const DebugPanelView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Debug Panel',
            style: appTheme.typography.titleLarge,
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Text(
            'Theme',
            style: appTheme.typography.titleMedium,
          ),
          const SizedBox(height: 8),
          const ThemePickerButton(),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              return state.when(
                initial: () => Text(
                  'Location not requested yet',
                  style: appTheme.typography.bodyMedium,
                ),
                loading: () => Row(
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: appTheme.navigation,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Getting location...',
                      style: appTheme.typography.bodyMedium,
                    ),
                  ],
                ),
                permissionGranted: () => Text(
                  'Permission granted! You can now get location.',
                  style: appTheme.typography.bodyMedium.copyWith(
                    color: appTheme.success,
                  ),
                ),
                permissionDenied: () => Text(
                  'Location permission denied. Please enable it in settings.',
                  style: appTheme.typography.bodyMedium.copyWith(
                    color: appTheme.error,
                  ),
                ),
                locationReceived: (location) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Location:',
                      style: appTheme.typography.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Latitude: ${location.latitude.toStringAsFixed(6)}',
                      style: appTheme.typography.bodySmall,
                    ),
                    Text(
                      'Longitude: ${location.longitude.toStringAsFixed(6)}',
                      style: appTheme.typography.bodySmall,
                    ),
                    Text(
                      'Accuracy: ${location.accuracy.toStringAsFixed(1)}m',
                      style: appTheme.typography.bodySmall,
                    ),
                    Text(
                      'Time: ${location.timestamp.toString().substring(0, 19)}',
                      style: appTheme.typography.bodySmall,
                    ),
                    if (location.isMocked)
                      Text(
                        'Mock location detected',
                        style: appTheme.typography.bodySmall.copyWith(
                          color: appTheme.warning,
                        ),
                      ),
                  ],
                ),
                error: (message) => Text(
                  'Error: $message',
                  style: appTheme.typography.bodyMedium.copyWith(
                    color: appTheme.error,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => context.read<LocationBloc>().add(
                    const LocationEvent.requestPermission(),
                  ),
                  child: const Text('Request Permission'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => context.read<LocationBloc>().add(
                    const LocationEvent.getCurrentLocation(),
                  ),
                  child: const Text('Get Location'),
                ),
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
                    state.isPickingLocation ? Icons.cancel : Icons.location_pin,
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
                Expanded(
                  child: ElevatedButton(
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
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: BlocBuilder<AuthBloc, AuthState>(
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
                        _,
                        _,
                        selectedSpot,
                        _,
                        _,
                      ) => selectedSpot,
                  orElse: () => null,
                );

                if (selectedSpot != null) {
                  return BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, authState) {
                      final userId = authState.maybeWhen(
                        authenticated: (user, profile) => user.id,
                        orElse: () => 'test-user',
                      );

                      return StreamBuilder<List<dynamic>>(
                        stream: context
                            .read<CheckInRepository>()
                            .watchUserCheckInsForSpot(userId, selectedSpot.id),
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
    );
  }
}

/// Legacy DebugPanel widget that wraps DebugPanelView in a card for backward compatibility
class DebugPanel extends StatelessWidget {
  const DebugPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Card(
      margin: const EdgeInsets.all(16),
      color: appTheme.surface.withAlpha((255 * 0.95).round()),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          appTheme.components.cards.borderRadius,
        ),
        side: BorderSide(
          color: appTheme.outline.withAlpha((255 * 0.5).round()),
        ),
      ),
      child: Padding(
        padding: appTheme.components.cards.padding,
        child: const DebugPanelView(),
      ),
    );
  }
}
