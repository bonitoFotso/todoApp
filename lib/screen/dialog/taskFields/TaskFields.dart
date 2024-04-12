import 'package:flutter/material.dart';

class TaskField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const TaskField({
    super.key,
    required this.labelText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: labelText,
          ),
          controller: controller,
        ),

        const SizedBox(height: 16), // Ajoutez un espacement vertical entre les champs
      ],
    );
  }
}
