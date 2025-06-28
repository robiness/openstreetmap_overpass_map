import 'package:supabase_flutter/supabase_flutter.dart';

import '../entities/user_profile.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> signOut();
  Future<UserProfile?> getProfile(String userId);
  Future<UserProfile?> createProfile(User user);
  User? get currentUser;
}
