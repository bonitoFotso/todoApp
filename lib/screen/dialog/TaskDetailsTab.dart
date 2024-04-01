import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/services/task/TaskProvider.dart';

class TaskDetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        Task task = taskProvider.task;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${task.name}'),
            SizedBox(height: 8),
            Text('Creation Date: ${task.creationDate}'),
            SizedBox(height: 8),
            Text('Is Ok: ${task.isOk}'),
            SizedBox(height: 8),
            Text('Modification Date: ${task.modificationDate}'),
          ],
        );
      },
    );
  }
}
