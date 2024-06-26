import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/models/DatabaseProvider.dart';
import 'package:todo/screen/HomePage.dart';
import 'package:todo/screen/LogingScreen.dart';
import 'package:todo/services/login/login_bloc.dart';
import 'package:todo/services/task/task_bloc.dart';
import 'package:todo/services/toggle/toggle_bloc.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Assurez-vous que les widgets sont initialisés
  final databaseProvider = DatabaseProvider(); // Initialisez DatabaseProvider
  await databaseProvider.createDatabase(); // Créez la base de données
  runApp(
    MyApp(
      databaseProvider: databaseProvider, // Passez DatabaseProvider à MyApp
    ),
  );
}

class MyApp extends StatelessWidget {
  final DatabaseProvider databaseProvider;

  const MyApp({super.key, required this.databaseProvider});
  // Ajoutez le paramètre databaseProvider dans le constructeur

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(databaseProvider),
        ),
        BlocProvider<ToggleBloc>(
          create: (context) => ToggleBloc(),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(databaseProvider)
            ..add(LoadTasks()), // Passez databaseProvider ici aussi
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginInitial) {
              return LoginScreen();
            } else if (state is LoginLoading) {
              return const CircularProgressIndicator();
            } else if (state is LoginSuccess) {
              return const HomePage();
            } else if (state is LoginFailure) {
              return const CircularProgressIndicator();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
