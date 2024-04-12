import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/services/task/TaskProvider.dart';
import 'package:todo/services/task/task_bloc.dart';

class UpDateTaskTab extends StatefulWidget {
  const UpDateTaskTab({Key? key}) : super(key: key);

  @override
  _UpDateTaskTabState createState() => _UpDateTaskTabState();
}

class _UpDateTaskTabState extends State<UpDateTaskTab> {
  late TextEditingController nameController;
  late TextEditingController creationDateController;
  late TextEditingController modificationDateController;
  late TextEditingController detailController;
  late TextEditingController groupIdController;
  late TextEditingController priorityController;
  late TextEditingController statusController;
  late bool isOk2; // State to store the value of Is Ok

  @override
  void initState() {
    super.initState();
    // Initialize the controllers
    nameController = TextEditingController();
    creationDateController = TextEditingController();
    modificationDateController = TextEditingController();
    detailController = TextEditingController();
    groupIdController = TextEditingController();
    priorityController = TextEditingController();
    statusController = TextEditingController();
    // Initialize isOk2 with the value of task.isOk
    isOk2 =
        Provider.of<TaskProvider>(context, listen: false).task.isOk ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        Task task = taskProvider.task;
        // Set initial values for text controllers
        nameController.text = task.name ?? '';
        creationDateController.text = task.creationDate ?? '';
        modificationDateController.text = task.modificationDate ?? '';
        detailController.text = task.detail ?? '';
        groupIdController.text = task.groupId.toString();
        priorityController.text = task.priority.toString();
        statusController.text = task.status ?? '';

        return Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(labelText: 'Task Name'),
                  controller: nameController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Creation Date'),
                  controller: creationDateController,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isOk2,
                      onChanged: (value) {
                        setState(() {
                          isOk2 = value ?? false; // Handle null value
                        });
                        print(isOk2);
                      },
                    ),
                    const Text('Is Ok'),
                  ],
                ),
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'Modification Date'),
                  controller: modificationDateController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Detail'),
                  controller: detailController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Group ID'),
                  controller: groupIdController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Priority'),
                  controller: priorityController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Status'),
                  controller: statusController,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final updatedTask = Task(
                      id: task.id,
                      name: nameController.text,
                      creationDate: creationDateController.text,
                      isOk: isOk2,
                      modificationDate: modificationDateController.text,
                      detail: detailController.text,
                      userId: 1, // Adjust as needed
                      groupId: int.tryParse(groupIdController.text) ?? 0,
                      priority: int.tryParse(priorityController.text) ?? 0,
                      status: statusController.text,
                    );

                    context.read<TaskBloc>().add(UpdateTaskEvent(updatedTask));
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
