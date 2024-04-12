import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/screen/task/taskDetailPage.dart';
import 'package:todo/services/task/task_bloc.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String _selectedStatus = 'All'; // Initial selected status

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskSuccess) {
          final Map<String, List<Object>> data = state.data;
          final List<Task> tasks = data['tasks'] as List<Task>;
          final List<TaskGroup> taskGroups =
              data['taskGroups'] as List<TaskGroup>;

          // Filter tasks based on selected status
          List<Task> filteredTasks =
              _filterTasksByStatus(tasks, _selectedStatus);

          return Column(
            children: [
              _buildFilterDropdown(),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final Task task = filteredTasks[index];
                    return ListTile(
                      title: Text(task.name!),
                      subtitle: Text('Creation Date: ${task.creationDate}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailPage(
                                task: task, taskGroups: taskGroups),
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context
                              .read<TaskBloc>()
                              .add(DeleteTaskEvent(task.id!));
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildFilterDropdown() {
    return DropdownButton<String>(
      value: _selectedStatus,
      onChanged: (value) {
        setState(() {
          _selectedStatus = value!;
        });
      },
      items: <String>[
        'All',
        'Completed',
        'Pending',
        'To Do',
        'In Progress',
        'Done',
        'Pending',
        'Cancelled',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  List<Task> _filterTasksByStatus(List<Task> tasks, String status) {
    if (status == 'All') {
      return tasks;
    } else if (status == 'Completed') {
      return tasks.where((task) => task.isOk == true).toList();
    } else if (status == 'Pending') {
      return tasks.where((task) => task.status == 'Pending').toList();
    } else if (status == 'To Do') {
      return tasks.where((task) => task.status == 'To Do').toList();
    } else {
      return tasks;
    }
  }
}
