import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:overpass_map/features/map_explorer/domain/repositories/check_in_repository.dart';

part 'debug_bloc.freezed.dart';
part 'debug_event.dart';
part 'debug_state.dart';

class DebugBloc extends Bloc<DebugEvent, DebugState> {
  DebugBloc({
    required CheckInRepository checkInRepository,
  }) : _checkInRepository = checkInRepository,
       super(const DebugState()) {
    on<_ToggleDebugMode>((event, emit) {
      emit(state.copyWith(isDebugModeEnabled: !state.isDebugModeEnabled));
    });

    on<_PickLocationToggled>((event, emit) {
      emit(state.copyWith(isPickingLocation: !state.isPickingLocation));
    });

    on<_CheckInRequested>((event, emit) async {
      print('🎯 DebugBloc: Check-in requested for spot ${event.spotId}');
      await _checkInRepository.createCheckIn(
        spotId: event.spotId,
        userId: event.userId,
      );
      print('✅ Check-in completed for spot ${event.spotId}');
    });

    on<_CheckOutRequested>((event, emit) async {
      print('🎯 DebugBloc: Check-out requested for spot ${event.spotId}');
      await _checkInRepository.deleteCheckInsForSpot(
        spotId: event.spotId,
        userId: event.userId,
      );
      print('✅ Check-out completed for spot ${event.spotId}');
    });
  }

  final CheckInRepository _checkInRepository;
}
