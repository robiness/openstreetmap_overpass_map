import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpass_map/features/auth/domain/repositories/auth_repository.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_event.dart';
import 'package:overpass_map/features/auth/presentation/bloc/auth_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import 'package:flutter/foundation.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const AuthState.initial()) {
    _userSubscription = _authRepository.authStateChanges.listen((user) {
      add(AuthEvent.userChanged(user: user));
    });

    on<UserChanged>(_onUserChanged);
    on<SignInWithGoogleRequested>(_onSignInWithGoogleRequested);
    on<SignInWithAppleRequested>(_onSignInWithAppleRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  Future<void> _onUserChanged(
    UserChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.user != null) {
      // User is authenticated
      debugPrint(
        'AuthBloc: User detected (ID: ${event.user!.id}). Fetching profile...',
      );
      emit(const AuthState.loading());
      var profile = await _authRepository.getProfile(event.user!.id);
      if (profile == null) {
        // Profile doesn't exist, create it
        debugPrint('AuthBloc: Profile not found. Creating new profile...');
        profile = await _authRepository.createProfile(event.user!);
      }

      if (profile != null) {
        debugPrint('AuthBloc: Profile found. Emitting Authenticated state.');
        emit(AuthState.authenticated(user: event.user!, profile: profile));
      } else {
        // Fallback: user is logged in but profile is missing and couldn't be created.
        debugPrint(
          'AuthBloc: CRITICAL - Profile missing and could not be created.',
        );
        emit(const AuthState.unauthenticated());
      }
    } else {
      // User is not authenticated
      debugPrint('AuthBloc: No user detected. Emitting Unauthenticated state.');
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onSignInWithGoogleRequested(
    SignInWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _authRepository.signInWithGoogle();
      // The authStateChanges stream will trigger the state update.
    } catch (e) {
      emit(AuthState.error(message: e.toString()));
    }
  }

  Future<void> _onSignInWithAppleRequested(
    SignInWithAppleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _authRepository.signInWithApple();
    } catch (e) {
      emit(AuthState.error(message: e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _authRepository.signOut();
      // The authStateChanges stream will emit null, which will lead to unauthenticated state.
    } catch (e) {
      emit(AuthState.error(message: e.toString()));
    }
  }
}
