import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/services/task/task_bloc.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({Key? key}) : super(key: key);

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  int? selectedGroupId;
  int? selectedPriority;
  late String selectedStatus;
  String name = '';
  String detail = '';

  final List<String> taskStatusOptions = [
    'To Do',
    'In Progress',
    'Done',
    'Pending',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();
    selectedStatus = taskStatusOptions.first;
    selectedPriority = 1;
    selectedGroupId = null;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: name);
    final TextEditingController detailController =
        TextEditingController(text: detail);

    return AlertDialog(
      title: Text('Add Task'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Task Name'),
              controller: nameController,
              onChanged: (value) => setState(() => name = value),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Detail'),
              controller: detailController,
              onChanged: (value) => setState(() => detail = value),
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskSuccess) {
                  List<TaskGroup> taskGroups =
                      state.data["taskGroups"] as List<TaskGroup>;

                  return DropdownButtonFormField<int>(
                    decoration: InputDecoration(labelText: 'Group ID'),
                    value: selectedGroupId,
                    onChanged: (newValue) =>
                        setState(() => selectedGroupId = newValue as int?),
                    items: taskGroups.map<DropdownMenuItem<int>>((group) {
                      return DropdownMenuItem<int>(
                        value: group
                            .id, // Utilisez l'identifiant unique comme valeur
                        child: Text(group.name),
                      );
                    }).toList(),
                  );
                } else {
                  return CircularProgressIndicator(); // Placeholder until groups are loaded
                }
              },
            ),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Priority'),
              value: selectedPriority,
              onChanged: (newValue) =>
                  setState(() => selectedPriority = newValue),
              items: List.generate(10, (index) {
                return DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text((index + 1).toString()),
                );
              }),
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Status'),
              value: selectedStatus,
              onChanged: (newValue) =>
                  setState(() => selectedStatus = newValue!),
              items: taskStatusOptions.map<DropdownMenuItem<String>>((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
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
            final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
            final currentTime = DateFormat('HH:mm:ss').format(DateTime.now());

            if (selectedGroupId != null && selectedStatus.isNotEmpty) {
              final addTask = Task(
                name: name,
                creationDate: '$currentDate $currentTime',
                isOk: false, // Default value for isOk
                modificationDate: '$currentDate $currentTime',
                detail: detail,
                userId: 1,
                groupId: selectedGroupId,
                priority: selectedPriority,
                status: selectedStatus,
              );

              context.read<TaskBloc>().add(AddTaskEvent(addTask));
              Navigator.of(context).pop();
            } else {
              // Handle case where either group or status is not selected
              // You can display an alert or take another appropriate action
            }
          },
        ),
      ],
    );
  }
}
