part of 'debug_bloc.dart';

@freezed
class DebugEvent with _$DebugEvent {
  const factory DebugEvent.toggleDebugMode() = _ToggleDebugMode;
  const factory DebugEvent.pickLocationToggled() = _PickLocationToggled;
  const factory DebugEvent.checkInRequested({
    required String spotId,
    required String userId,
  }) = _CheckInRequested;
  const factory DebugEvent.checkOutRequested({
    required String spotId,
    required String userId,
  }) = _CheckOutRequested;
  const factory DebugEvent.logMessage(String message) = _LogMessage;
}
