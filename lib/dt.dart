import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo List',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key, Key? key});

  @override
  createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late List<String> todoNames = [];
  late List<bool> todoCompleted = [];
  late List<bool> taskSelected = [];
  late TextEditingController controller;
  late Database database;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    initDatabase();
  }

  Future<void> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final String dbPath = path.join(databasesPath, 'todo.db');

    database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, task TEXT, completed INTEGER)',
        );
      },
    );

    await _updateTodoList();
  }

  Future<void> _updateTodoList() async {
    List<Map<String, dynamic>> tasks = await database.query('todos');
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

    await database.rawDelete(
      'DELETE FROM todos WHERE task IN (${selectedTasks.map((_) => '?').join(',')})',
      selectedTasks,
    );

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
              await database.transaction((txn) async {
                await txn.rawInsert(
                  'INSERT INTO todos(task, completed) VALUES(?, ?)',
                  [text, 0],
                );
              });
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
