import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/TodoList.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/screen/dialog/AddTaskDialog.dart';
import 'package:todo/screen/dialog/TaskDetailsDialog.dart';
import 'package:todo/screen/task/TaskPage.dart';
import 'package:todo/services/task/task_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Todo"),
        ),
        body: [
          TaskPage(),
          TaskPage(),
        ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setCurrentIndex(index),
          selectedItemColor: Colors.green,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Task'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: 'planning')
          ],
        ),
      ),
    );
  }
}
