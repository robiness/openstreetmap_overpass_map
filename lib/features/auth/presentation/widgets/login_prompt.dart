import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_event.dart';

class LoginPrompt extends StatelessWidget {
  const LoginPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Join the Adventure!',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Create an account to check-in and save your discoveries.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.g_mobiledata,
            ), // Replace with a proper Google icon later
            label: const Text('Sign in with Google'),
            onPressed: () {
              context.read<AuthBloc>().add(
                const AuthEvent.signInWithGoogleRequested(),
              );
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            icon: const Icon(Icons.apple),
            label: const Text('Sign in with Apple'),
            onPressed: () {
              context.read<AuthBloc>().add(
                const AuthEvent.signInWithAppleRequested(),
              );
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
