part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username; // Déclaration du paramètre username
  final String password; // Déclaration du paramètre password

  const LoginButtonPressed(
      {required this.username,
      required this.password}); // Utilisation du paramètre dans le constructeur

  @override
  List<Object> get props => [username, password];

  // Vous pouvez ajouter d'autres propriétés ici si nécessaire
}
