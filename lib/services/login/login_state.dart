part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  final bool isLoading;
  const LoginInitial(this.isLoading);
  @override
  List<Object> get props => [isLoading];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  //LoginFailure(String string);
}
