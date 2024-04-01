part of 'toggle_bloc.dart';

sealed class ToggleEvent extends Equatable {
  const ToggleEvent();

  @override
  List<Object> get props => [];
}

class ToggleSubmitEvent extends ToggleEvent {}
