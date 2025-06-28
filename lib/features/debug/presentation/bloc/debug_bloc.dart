import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'debug_bloc.freezed.dart';
part 'debug_event.dart';
part 'debug_state.dart';

class DebugBloc extends Bloc<DebugEvent, DebugState> {
  DebugBloc() : super(const DebugState()) {
    on<_ToggleDebugMode>((event, emit) {
      emit(state.copyWith(isDebugModeEnabled: !state.isDebugModeEnabled));
    });

    on<_PickLocationToggled>((event, emit) {
      emit(state.copyWith(isPickingLocation: !state.isPickingLocation));
    });
  }
}
