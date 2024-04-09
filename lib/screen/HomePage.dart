import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/screen/dialog/AddTaskDialog.dart';
import 'package:todo/screen/dialog/TaskDetailsDialog.dart';
import 'package:todo/services/task/task_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TaskPage();
  }
}

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDoList'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            itemCount: state.tasks.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (context, index) {
              final Task task = state.tasks[index];
              print(task.isOk);
              Color backgroundColor =
                  task.isOk ?? false ? Colors.green : Colors.white;
              return Container(
                color: backgroundColor,
                child: Card(
                  elevation: 3.0,
                  child: ListTile(
                    title: Text(task.name!),
                    subtitle: Text('Creation Date: ${task.isOk}'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return TaskDetailDialog(task: task);
                        },
                      );
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        context.read<TaskBloc>().add(DeleteTaskEvent(task.id!));
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddTaskDialog();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
