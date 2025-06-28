part of 'debug_bloc.dart';

@freezed
class DebugState with _$DebugState {
  const factory DebugState({
    @Default(false) bool isDebugModeEnabled,
  }) = _DebugState;
}
