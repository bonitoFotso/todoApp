import 'package:flutter/material.dart';
import 'package:todo/DatabaseHelper.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key});

  @override
  createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late List<String> todoNames = [];
  late List<bool> todoCompleted = [];
  late List<bool> taskSelected = [];
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    DatabaseHelper.initDatabase();
    _updateTodoList();
  }

  Future<void> _updateTodoList() async {
    List<Map<String, dynamic>> tasks = await DatabaseHelper.getTasks();
    setState(() {
      todoNames = tasks.map((task) => task['task'] as String).toList();
      todoCompleted = tasks.map((task) => task['completed'] == 1).toList();
      taskSelected = List.generate(todoNames.length, (_) => false);
    });
  }

  Future<void> _deleteSelectedTasks() async {
    List<String> selectedTasks = [];

    for (int i = 0; i < taskSelected.length; i++) {
      if (taskSelected[i]) {
        selectedTasks.add(todoNames[i]);
      }
    }

    await DatabaseHelper.deleteTasks(selectedTasks);
    await _updateTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteSelectedTasks(),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Enter a task',
            ),
            onSubmitted: (text) async {
              await DatabaseHelper.insertTask(text);
              await _updateTodoList();
              controller.clear();
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoNames.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  title: Text(
                    todoNames[index],
                    style: TextStyle(
                      decoration: todoCompleted[index] ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  value: taskSelected[index],
                  onChanged: (bool? value) {
                    setState(() {
                      taskSelected[index] = value!;
                    });
                  },
                );
                Row(
              children: [
                Checkbox(
                  value: isOk,
                  onChanged: (value) {
                    setState(() {
                      isOk = value ?? false; // Mettez à jour la valeur de Is Ok
                    });
                  },
                ),
                Text('Is Ok'),
              ],
            ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
