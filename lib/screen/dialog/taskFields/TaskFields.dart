import 'package:flutter/material.dart';

class TaskField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const TaskField({
    Key? key,
    required this.labelText,
    required this.controller,
  }) : super(key: key);

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

        SizedBox(height: 16), // Ajoutez un espacement vertical entre les champs
      ],
    );
  }
}
