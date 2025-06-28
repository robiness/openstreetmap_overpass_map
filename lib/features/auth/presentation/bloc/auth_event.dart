import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.appStarted() = AppStarted;
  const factory AuthEvent.userChanged({User? user}) = UserChanged;
  const factory AuthEvent.signInWithGoogleRequested() =
      SignInWithGoogleRequested;
  const factory AuthEvent.signInWithAppleRequested() = SignInWithAppleRequested;
  const factory AuthEvent.signOutRequested() = SignOutRequested;
}
