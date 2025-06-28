part of 'debug_bloc.dart';

@freezed
class DebugEvent with _$DebugEvent {
  const factory DebugEvent.toggleDebugMode() = _ToggleDebugMode;
  const factory DebugEvent.pickLocationToggled() = _PickLocationToggled;
}
