import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/services/login/login_bloc.dart';
import 'package:todo/services/toggle/toggle_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  // Fonction pour gérer l'action de l'icône
  static void _onIconPressed(BuildContext context) {
    context.read<ToggleBloc>().add(ToggleSubmitEvent());
  }

  // Widget pour construire les champs de texte
  Widget _buildTextField({
    required String labelText,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: suffixIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connexion"), // Utilisation de la langue cohérente
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(
              labelText:
                  'Nom d\'utilisateur', // Utilisation de la langue cohérente
              controller: usernameController,
            ),
            const SizedBox(height: 16),
            BlocBuilder<ToggleBloc, ToggleState>(
              builder: (context, state) {
                return _buildTextField(
                  labelText:
                      'Mot de passe', // Utilisation de la langue cohérente
                  controller: passwordController,
                  obscureText: (state as ToggleInitial).isOn,
                  suffixIcon: IconButton(
                    icon: FaIcon(state.isOn
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash),
                    onPressed: () => _onIconPressed(context),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    final username = usernameController.text;
                    final password = passwordController.text;
                    context.read<LoginBloc>().add(LoginButtonPressed(
                          username: username,
                          password: password,
                        ));
                  },
                  child: (state as LoginInitial).isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Connexion'), // Utilisation de la langue cohérente
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
