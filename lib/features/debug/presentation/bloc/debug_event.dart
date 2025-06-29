part of 'debug_bloc.dart';

@freezed
class DebugEvent with _$DebugEvent {
  const factory DebugEvent.toggleDebugMode() = _ToggleDebugMode;
  const factory DebugEvent.pickLocationToggled() = _PickLocationToggled;
  const factory DebugEvent.checkInRequested({
    required int spotId,
    required String userId,
  }) = _CheckInRequested;
  const factory DebugEvent.checkOutRequested({
    required int spotId,
    required String userId,
  }) = _CheckOutRequested;
}
