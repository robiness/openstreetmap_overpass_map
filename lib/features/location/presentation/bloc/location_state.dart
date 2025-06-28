part of 'location_bloc.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState.initial() = _Initial;
  const factory LocationState.loading() = _Loading;
  const factory LocationState.permissionGranted() = _PermissionGranted;
  const factory LocationState.permissionDenied() = _PermissionDenied;
  const factory LocationState.locationReceived({
    required LocationData location,
  }) = _LocationReceived;
  const factory LocationState.error({required String message}) = _Error;
}
