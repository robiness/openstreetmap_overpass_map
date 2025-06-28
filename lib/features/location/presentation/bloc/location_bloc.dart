import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/location_data.dart';
import '../../domain/repositories/location_repository.dart';

part 'location_bloc.freezed.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository;
  StreamSubscription<LocationData>? _locationSubscription;

  LocationBloc({required LocationRepository locationRepository})
    : _locationRepository = locationRepository,
      super(const LocationState.initial()) {
    on<LocationEvent>((event, emit) async {
      await event.when(
        requestPermission: () async => await _onRequestPermission(emit),
        getCurrentLocation: () async => await _onGetCurrentLocation(emit),
        setDebugLocation: (location) async =>
            await _onSetDebugLocation(emit, location),
      );
    });
  }

  Future<void> _onRequestPermission(Emitter<LocationState> emit) async {
    try {
      emit(const LocationState.loading());

      final hasPermission = await _locationRepository.hasLocationPermission();
      if (hasPermission) {
        emit(const LocationState.permissionGranted());
        return;
      }

      final permissionGranted = await _locationRepository
          .requestLocationPermission();
      if (permissionGranted) {
        emit(const LocationState.permissionGranted());
      } else {
        emit(const LocationState.permissionDenied());
      }
    } catch (error) {
      emit(
        LocationState.error(message: 'Permission error: ${error.toString()}'),
      );
    }
  }

  Future<void> _onGetCurrentLocation(Emitter<LocationState> emit) async {
    try {
      emit(const LocationState.loading());

      final hasPermission = await _locationRepository.hasLocationPermission();
      if (!hasPermission) {
        emit(const LocationState.permissionDenied());
        return;
      }

      final isServiceEnabled = await _locationRepository
          .isLocationServiceEnabled();
      if (!isServiceEnabled) {
        emit(
          const LocationState.error(message: 'Location services are disabled'),
        );
        return;
      }

      final location = await _locationRepository.getCurrentLocation();
      if (location != null) {
        emit(LocationState.locationReceived(location: location));
      } else {
        emit(const LocationState.error(message: 'Failed to get location'));
      }
    } catch (error) {
      emit(LocationState.error(message: 'Location error: ${error.toString()}'));
    }
  }

  Future<void> _onSetDebugLocation(
    Emitter<LocationState> emit,
    LocationData? location,
  ) async {
    try {
      if (kDebugMode) {
        _locationRepository.setDebugLocation(location);
        if (location != null) {
          emit(LocationState.locationReceived(location: location));
        }
      }
    } catch (error) {
      emit(
        LocationState.error(
          message: 'Debug location error: ${error.toString()}',
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}
