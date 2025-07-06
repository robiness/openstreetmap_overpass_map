import 'package:flutter/foundation.dart';
import 'package:overpass_map/features/auth/domain/entities/user_profile.dart';
import 'package:overpass_map/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabaseClient;

  AuthRepositoryImpl({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  @override
  Stream<User?> get authStateChanges => _supabaseClient.auth.onAuthStateChange
      .map((event) => event.session?.user);

  @override
  User? get currentUser => _supabaseClient.auth.currentUser;

  @override
  Future<UserProfile?> getProfile(String userId) async {
    try {
      final response = await _supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId);

      if (response.isEmpty) {
        return null;
      }

      // The query might return multiple rows in case of a misconfiguration.
      // We'll take the first one.
      return UserProfile.fromJson(response.first);
    } catch (e) {
      // Profile probably doesn't exist for this user yet.
      return null;
    }
  }

  @override
  Future<UserProfile?> createProfile(User user) async {
    final userData = user.userMetadata ?? {};

    // ---- START DEBUG LOGGING ----
    debugPrint('--- AUTH DEBUG ---');
    debugPrint('Received user metadata: $userData');
    // ---- END DEBUG LOGGING ----

    final profileData = {
      'id': user.id,
      'full_name': userData['name'],
      'avatar_url': userData['picture'],
      'updated_at': DateTime.now().toIso8601String(),
    };

    try {
      final response = await _supabaseClient
          .from('profiles')
          .upsert(profileData)
          .select('*, created_at');

      if (response.isEmpty) {
        return null;
      }
      return UserProfile.fromJson(response.first);
    } catch (e) {
      // Handle or log error
      return null;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    await _supabaseClient.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: kDebugMode
          ? 'http://localhost:3000/'
          : 'https://tgmp.netlify.app/',
    );
  }

  @override
  Future<void> signInWithApple() async {
    await _supabaseClient.auth.signInWithOAuth(
      OAuthProvider.apple,
      redirectTo: kDebugMode
          ? 'http://localhost:3000/'
          : 'https://tgmp.netlify.app/',
    );
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }
}
