import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_state.dart';
import 'package:overpass_map/features/auth/presentation/widgets/login_prompt.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';
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
                        _performCheckIn(context, authState.user.id),
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

  void _performCheckIn(BuildContext context, String userId) async {
    try {
      await context.read<CheckInRepository>().createCheckIn(
        spotId: spot!.id,
        userId: userId,
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Check-in failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
