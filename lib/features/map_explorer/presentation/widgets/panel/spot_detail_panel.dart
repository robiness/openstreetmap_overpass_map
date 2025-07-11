import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_state.dart';
import 'package:overpass_map/features/auth/presentation/widgets/login_prompt.dart';
import 'package:overpass_map/features/location/presentation/bloc/location_bloc.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
import 'package:overpass_map/features/map_explorer/domain/exceptions/check_in_exception.dart';
import 'package:overpass_map/features/map_explorer/domain/repositories/check_in_repository.dart';
import 'package:overpass_map/features/map_explorer/presentation/widgets/panel/feedback_modal.dart';

class SpotDetailPanel extends StatelessWidget {
  final Spot? spot;

  const SpotDetailPanel({super.key, this.spot});

  @override
  Widget build(BuildContext context) {
    if (spot == null) {
      return const SizedBox.shrink();
    }
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    spot!.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      authenticated: (user, profile) => IconButton(
                        icon: const Icon(Icons.flag_outlined),
                        onPressed: () => _showFeedbackModal(context, spot!),
                        tooltip: 'Report an issue with this spot',
                      ),
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(spot!.category, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.location_on),
                label: const Text('Check-in Here'),
                onPressed: () {
                  context.read<AuthBloc>().state.map(
                    initial: (_) => _showLogin(context),
                    loading: (_) {}, // Do nothing while loading
                    authenticated: (authState) =>
                        _performCheckInWithLocation(context, authState.user.id),
                    unauthenticated: (_) => _showLogin(context),
                    error: (_) => _showLogin(context),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _performCheckInWithLocation(BuildContext context, String userId) async {
    try {
      // First, get the current location
      final locationBloc = context.read<LocationBloc>();
      
      // Request current location
      locationBloc.add(const LocationEvent.getCurrentLocation());
      
      // Wait for location result
      await for (final locationState in locationBloc.stream) {
        if (locationState.maybeWhen(
          locationReceived: (location) {
            // Location received, proceed with check-in
            _performCheckInWithValidatedLocation(context, userId, location);
            return true;
          },
          error: (message) {
            // Location error
            _showLocationError(context, message);
            return true;
          },
          permissionDenied: () {
            // Permission denied
            _showLocationError(context, 'Location permission is required to check in. Please enable location services.');
            return true;
          },
          orElse: () => false, // Keep waiting for other states
        )) {
          break; // Exit the stream when we get a final result
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Check-in failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _performCheckInWithValidatedLocation(
    BuildContext context, 
    String userId, 
    dynamic location
  ) async {
    try {
      await context.read<CheckInRepository>().createCheckInWithLocation(
        spotId: spot!.id,
        userId: userId,
        userLocation: location,
        spotLocation: spot!.location,
        isDebugMode: false, // Normal check-in mode
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Check-in successful!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        String errorMessage = 'Check-in failed: $e';
        
        // Provide specific error messages for CheckInException
        if (e is CheckInException) {
          switch (e.type) {
            case CheckInErrorType.tooFarAway:
              errorMessage = e.message;
              break;
            case CheckInErrorType.locationUnavailable:
              errorMessage = 'Location is not available. Please try again.';
              break;
            case CheckInErrorType.permissionDenied:
              errorMessage = 'Location permission is required to check in.';
              break;
            case CheckInErrorType.unknown:
              errorMessage = 'Check-in failed: ${e.message}';
              break;
          }
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  void _showLocationError(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location error: $message'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  void _showLogin(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const LoginPrompt(),
    );
  }

  void _showFeedbackModal(BuildContext context, Spot spot) {
    showModalBottomSheet(
      context: context,
      builder: (_) => FeedbackModal(spot: spot),
      isScrollControlled: true,
    );
  }
}
