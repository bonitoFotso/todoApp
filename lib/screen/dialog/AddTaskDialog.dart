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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final TextEditingController groupIdController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  bool isOk2 = false;

  @override
  Widget build(BuildContext context) {
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
            Row(
              children: [
                Checkbox(
                  value: isOk2,
                  onChanged: (value) {
                    setState(() {
                      isOk2 = value ?? false;
                    });
                  },
                ),
                Text('Is Ok'),
              ],
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
              creationDate: DateTime.now().toString(),
              isOk: isOk2,
              modificationDate: DateTime.now().toString(),
              detail: detailController.text,
              userId: 1,
              groupId: int.tryParse(groupIdController.text) ?? 0,
              priority: int.tryParse(priorityController.text) ?? 0,
              status: statusController.text,
            );
            print('task ok');
            print(addTask.isOk);
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
