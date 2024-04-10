import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/services/task/task_bloc.dart';

class AddTaskDialog extends StatefulWidget {
  final Map<String, List<Object>> dataTask;
  const AddTaskDialog({Key? key, required this.dataTask}) : super(key: key);

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  bool isOk = false;
  TaskGroup? selectedGroup;
  int? selectedPriority;
  String? selectedStatus;

  String _name = '';
  String _detail = '';

  List<String> taskStatusOptions = [
    'To Do',
    'In Progress',
    'Done',
    'Pending',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();
    List<Object>? taskGroups = widget.dataTask['taskGroups'];
    if (taskGroups != null && taskGroups.isNotEmpty) {
      selectedGroup = taskGroups[0] as TaskGroup?;
    }
    selectedStatus = taskStatusOptions
        .first; // Initialize selected status to the first status option
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: _name);
    final TextEditingController detailController =
        TextEditingController(text: _detail);
    List<Object>? taskGroups = widget.dataTask['taskGroups'];

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
              onChanged: (value) {
                _name = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Detail',
              ),
              controller: detailController,
              onChanged: (value) {
                _detail = value;
              },
            ),
            DropdownButtonFormField<TaskGroup>(
              decoration: InputDecoration(
                labelText: 'Group ID',
              ),
              value: selectedGroup,
              onChanged: (TaskGroup? newValue) {
                setState(() {
                  selectedGroup = newValue;
                });
              },
              items:
                  taskGroups!.map<DropdownMenuItem<TaskGroup>>((Object group) {
                return DropdownMenuItem<TaskGroup>(
                  value: group as TaskGroup,
                  child: Text((group as TaskGroup).name),
                );
              }).toList(),
            ),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(
                labelText: 'Priority',
              ),
              value: selectedPriority,
              onChanged: (int? newValue) {
                setState(() {
                  selectedPriority = newValue;
                });
              },
              items: List.generate(10, (index) {
                return DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text((index + 1).toString()),
                );
              }),
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Status',
              ),
              value: selectedStatus,
              onChanged: (String? newValue) {
                setState(() {
                  selectedStatus = newValue;
                });
              },
              items: taskStatusOptions
                  .map<DropdownMenuItem<String>>((String status) {
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
            String currentDate =
                DateFormat('yyyy-MM-dd').format(DateTime.now());
            String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());

            if (selectedGroup != null && selectedStatus != null) {
              final addTask = Task(
                name: _name,
                creationDate: '$currentDate $currentTime',
                isOk: isOk,
                modificationDate: '$currentDate $currentTime',
                detail: _detail,
                userId: 1,
                groupId: selectedGroup!.id,
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
