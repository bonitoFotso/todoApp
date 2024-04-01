import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/services/task/task_bloc.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({Key? key}) : super(key: key);

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  bool isOk2 =
      false; // Déclaration de la variable pour stocker l'état de la case à cocher

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController creationDateController =
        TextEditingController();
    final TextEditingController modificationDateController =
        TextEditingController();
    final TextEditingController detailController = TextEditingController();
    final TextEditingController groupIdController = TextEditingController();
    final TextEditingController priorityController = TextEditingController();
    final TextEditingController statusController = TextEditingController();

    return AlertDialog(
      title: Text('Add Task'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Task Name',
              ),
              controller: nameController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Creation Date',
              ),
              controller: creationDateController,
            ),
            Row(
              children: [
                Checkbox(
                  value: isOk2,
                  onChanged: (value) {
                    setState(() {
                      isOk2 = value ??
                          false; // Mise à jour de l'état de la case à cocher
                    });
                  },
                ),
                Text('Is Ok'),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Date',
              ),
              controller: TextEditingController(
                text: modificationDateController.text,
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  setState(() {
                    modificationDateController.text = pickedDate
                        .toString(); // Mettre à jour la date sélectionnée dans le contrôleur de texte
                    print(modificationDateController.text);
                  });
                }
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Detail',
              ),
              controller: detailController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Group ID',
              ),
              controller: groupIdController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Priority',
              ),
              controller: priorityController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Status',
              ),
              controller: statusController,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            final addTask = Task(
              name: nameController.text,
              creationDate: creationDateController.text,
              isOk: isOk2, // Conversion de booléen à entier
              modificationDate: modificationDateController.text,
              detail: detailController.text,
              userId: 1,
              groupId: int.tryParse(groupIdController.text) ?? 0,
              priority: int.tryParse(priorityController.text) ?? 0,
              status: statusController.text,
            );
            print('task name');
            print(addTask.name);
            print('task date');
            print(addTask.modificationDate);
            context.read<TaskBloc>().add(AddTaskEvent(addTask));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
