import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/features/auth/domain/entities/user_profile.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_state.dart';
import 'package:overpass_map/features/auth/presentation/widgets/login_prompt.dart';

class UserProfileButton extends StatelessWidget {
  const UserProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) {
        final wasAuthenticated =
            previous.mapOrNull(authenticated: (_) => true) ?? false;
        final isAuthenticated =
            current.mapOrNull(authenticated: (_) => true) ?? false;

        if (wasAuthenticated != isAuthenticated) {
          return true; // Rebuild when auth status changes
        }

        if (isAuthenticated) {
          final previousProfile = previous.mapOrNull(
            authenticated: (s) => s.profile,
          );
          final currentProfile = current.mapOrNull(
            authenticated: (s) => s.profile,
          );
          return previousProfile !=
              currentProfile; // Rebuild if profile data changes
        }

        return false;
      },
      builder: (context, state) {
        return state.when(
          initial: () => _buildLoginButton(context),
          loading: () =>
              const Center(child: CircularProgressIndicator(strokeWidth: 2.0)),
          authenticated: (user, profile) =>
              _buildProfileAvatar(context, profile),
          unauthenticated: () => _buildLoginButton(context),
          error: (message) => _buildLoginButton(context),
        );
      },
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => const LoginPrompt(),
        );
      },
      child: const Text('Login'),
    );
  }

  Widget _buildProfileAvatar(BuildContext context, UserProfile user) {
    final avatarUrl = user.avatarUrl;
    final initials = (user.username?.isNotEmpty ?? false)
        ? user.username!.substring(0, 1).toUpperCase()
        : '?';

    return InkWell(
      onTap: () {
        // TODO: Implement profile menu (e.g., show a dropdown with Sign Out)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile menu coming soon!')),
        );
      },
      child: CircleAvatar(
        backgroundImage: (avatarUrl != null && avatarUrl.isNotEmpty)
            ? CachedNetworkImageProvider(avatarUrl)
            : null,
        child: (avatarUrl == null || avatarUrl.isEmpty) ? Text(initials) : null,
      ),
    );
  }
}
