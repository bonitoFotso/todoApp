part of 'toggle_bloc.dart';

abstract class ToggleState extends Equatable {
  const ToggleState();

  @override
  List<Object?> get props => [];
}

class ToggleInitial extends ToggleState {
  final bool isOn;
  const ToggleInitial(this.isOn);

  @override
  List<Object?> get props => [isOn];
}
