import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/services/task/task_bloc.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({
    super.key,
  });

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>(); // Declare the form key

  late int? selectedGroupId;
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Your TextFormField for task name
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Task Name'),
                  controller: nameController,
                  //onChanged: (value) => setState(() => name = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task name';
                    }
                    return null;
                  },
                ),

// Your TextFormField for task detail
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Detail'),
                  controller: detailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter task details';
                    }
                    //setState(() => detail = value);
                    return null;
                  },
                ),
                BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is TaskSuccess) {
                      List<TaskGroup> taskGroups =
                          state.data["taskGroups"] as List<TaskGroup>;

                      return DropdownButtonFormField<int>(
                        decoration: const InputDecoration(labelText: 'Group ID'),
                        value: selectedGroupId,
                        onChanged: (newValue) {
                          setState(() {
                            selectedGroupId = newValue;
                            name = nameController.text;
                            detail = detailController.text;
                          });
                        },
                        items: taskGroups.map<DropdownMenuItem<int>>((group) {
                          return DropdownMenuItem<int>(
                            value: group
                                .id, // Utilisez l'identifiant unique comme valeur
                            child: Text(group.name),
                          );
                        }).toList(),
                      );
                    } else {
                      return const CircularProgressIndicator(); // Placeholder until groups are loaded
                    }
                  },
                ),
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(labelText: 'Priority'),
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
                  decoration: const InputDecoration(labelText: 'Status'),
                  value: selectedStatus,
                  onChanged: (newValue) =>
                      setState(() => selectedStatus = newValue!),
                  items:
                      taskStatusOptions.map<DropdownMenuItem<String>>((status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                ),
                // Submit button
                // Submit button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, update the name and detail fields
                      setState(() {
                        name = nameController.text;
                        detail = detailController.text;
                      });

                      // Proceed with adding the task
                      final currentDate =
                          DateFormat('yyyy-MM-dd').format(DateTime.now());
                      final currentTime =
                          DateFormat('HH:mm:ss').format(DateTime.now());

                      if (selectedGroupId != null &&
                          selectedStatus.isNotEmpty) {
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
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
