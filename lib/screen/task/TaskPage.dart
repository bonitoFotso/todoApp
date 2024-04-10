import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/screen/dialog/AddTaskDialog.dart';
import 'package:todo/screen/dialog/TaskDetailsDialog.dart';
import 'package:todo/services/task/task_bloc.dart';

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskSuccess) {
          final Map<String, List<Object>> data = state.data;
          final List<Task> tasks = data['tasks'] as List<Task>;
          final List<TaskGroup> taskGroups =
              data['taskGroups'] as List<TaskGroup>;

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final Task task = tasks[index];
              return ListTile(
                title: Text(task.name!),
                subtitle: Text('Creation Date: ${task.status}'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TaskDetailDialog(
                          task: task, taskGroups: taskGroups);
                    },
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    context.read<TaskBloc>().add(DeleteTaskEvent(task.id!));
                  },
                ),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    //floatingActionButton: BlocBuilder<TaskBloc, TaskState>(
    //  builder: (context, state) {
    //    if (state is TaskSuccess) {
    //      final Map<String, List<Object>> data = state.data;
    //      return FloatingActionButton(
    //        onPressed: () {
    //          showDialog(
    //            context: context,
    //            builder: (BuildContext context) {
    //              return AddTaskDialog(dataTask: data);
    //            },
    //          );
    //        },
    //        child: Icon(Icons.add),
    //      );
    //    } else {
    //      return Container();
    //    }
    //  },
    //),
  }
}
