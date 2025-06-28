part of 'location_bloc.dart';

@freezed
class LocationEvent with _$LocationEvent {
  const factory LocationEvent.requestPermission() = _RequestPermission;
  const factory LocationEvent.getCurrentLocation() = _GetCurrentLocation;
  const factory LocationEvent.setDebugLocation({LocationData? location}) =
      _SetDebugLocation;
}
