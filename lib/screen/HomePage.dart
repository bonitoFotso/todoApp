import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:todo/screen/task/AddTaskPage.dart';
import 'package:todo/screen/task/TaskPage.dart';

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: [
            const Text("Todo"),
            const Text("planning"),
            const Text("Add Task"),
            const Text("Todo"),
            const Text("Todo"),
          ][_currentIndex],
        ),
        body: [
          TaskPage(),
          TaskPage(),
          const AddTaskPage(),
          const AddTaskPage(),
          const AddTaskPage(),
        ][_currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.green,
          color: Colors.green,
          animationDuration: const Duration(milliseconds: 300),
          items: const <Widget>[
            Icon(Icons.home, size: 26, color: Colors.white),
            Icon(Icons.message, size: 26, color: Colors.white),
            Icon(Icons.add, size: 26, color: Colors.white),
            Icon(Icons.notifications, size: 26, color: Colors.white),
            Icon(Icons.person, size: 26, color: Colors.white),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
