import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'toggle_event.dart';
part 'toggle_state.dart';

class ToggleBloc extends Bloc<ToggleEvent, ToggleState> {
  ToggleBloc() : super(const ToggleInitial(false)) {
    on<ToggleSubmitEvent>((event, emit) {
      final currentState = state;
      if (currentState is ToggleInitial) {
        emit(ToggleInitial(!currentState.isOn));
      }
    });
  }
}
