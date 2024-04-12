import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:todo/screen/dialog/AddTaskDialog.dart';
import 'package:todo/screen/task/AddTaskPage.dart';
import 'package:todo/screen/task/TaskPage.dart';
import 'package:todo/screen/task/dashboardPage.dart';
import 'package:todo/screen/task/historiquePage.dart';
import 'package:todo/screen/task/planningPage.dart';
import 'package:todo/screen/task/profilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: [
          const Text("Liste de tâches"),
          const Text("Planning"),
          const Text("Tableau de bord"),
          const Text("Historique"),
          const Text("Profil"),
        ][_currentIndex],
        actions: _buildActions(_currentIndex),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Option 1'),
              onTap: () {
                // Action spécifique pour l'option 1
              },
            ),
            ListTile(
              title: Text('Option 2'),
              onTap: () {
                // Action spécifique pour l'option 2
              },
            ),
            // Ajoutez d'autres éléments de menu ici
          ],
        ),
      ),
      body: [
        TaskPage(),
        PanningPage(),
        DashboardPage(),
        HistoriquePage(),
        ProfilePage(),
      ][_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.green,
        color: Colors.green,
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(Icons.home, size: 26, color: Colors.white),
          Icon(Icons.calendar_today, size: 26, color: Colors.white),
          Icon(Icons.dashboard, size: 26, color: Colors.white),
          Icon(Icons.history, size: 26, color: Colors.white),
          Icon(Icons.person, size: 26, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  List<Widget>? _buildActions(int index) {
    switch (index) {
      case 0:
        return [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTaskPage()),
              );
            },
          ),
        ];
      // Ajoutez d'autres cas pour d'autres pages si nécessaire
      default:
        return null;
    }
  }
}
