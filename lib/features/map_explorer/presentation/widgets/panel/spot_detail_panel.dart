import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:overpass_map/features/auth/presentation/widgets/login_prompt.dart';
import 'package:overpass_map/features/map_explorer/domain/entities/spot.dart';

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
            Text(spot!.name, style: Theme.of(context).textTheme.headlineSmall),
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
                    authenticated: (_) => _performCheckIn(context),
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

  void _performCheckIn(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Check-in successful! (Not really)'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showLogin(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const LoginPrompt(),
    );
  }
}
