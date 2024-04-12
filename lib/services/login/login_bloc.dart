import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/models/DatabaseProvider.dart';

// login_bloc.dart
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DatabaseProvider databaseProvider;

  LoginBloc(this.databaseProvider) : super(const LoginInitial(false)) {
    on<LoginButtonPressed>((event, emit) async {
      final username = event.username;
      final password = event.password;

      final isValid = await isValidCredentials(username, password);
      if (isValid) {
        emit(LoginLoading());
        await Future.delayed(const Duration(
            seconds:
                2)); // Simuler une tâche asynchrone, par exemple une requête réseau
        emit(LoginSuccess());
      } else {
        emit(LoginFailure());
      }
    });
  }

  Future<bool> isValidCredentials(String username, String password) async {
    final user = await DatabaseProvider.getUserByUsername(username);
    print(user);
    //return user != null && user['password'] == password;
    return true;
  }
}
