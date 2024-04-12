import 'package:flutter/material.dart';

// Définir un thème personnalisé pour votre application
final ThemeData customTheme = ThemeData(
  primaryColor: Colors.blue, // Couleur principale de votre application
  hintColor: Colors.greenAccent, // Couleur d'accentuation
  scaffoldBackgroundColor: Colors.white, // Couleur de fond des pages
  appBarTheme: const AppBarTheme(
    color: Colors.blue, // Couleur de la barre d'application
  ),
  cardTheme: const CardTheme(
    color: Colors.white, // Couleur des cartes
    elevation: 4, // Élévation par défaut des cartes
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Colors.black), // Style du texte de titre
    bodyMedium: TextStyle(color: Colors.black87), // Style du texte du corps
  ),
);

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tâches à faire aujourd\'hui:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TaskCard(
              taskTitle: 'Tâche 1',
              taskDescription: 'Description de la tâche 1',
              dueDate: 'Aujourd\'hui',
            ),
            TaskCard(
              taskTitle: 'Tâche 2',
              taskDescription: 'Description de la tâche 2',
              dueDate: 'Aujourd\'hui',
            ),
            SizedBox(height: 16),
            Text(
              'Tâches en retard:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TaskCard(
              taskTitle: 'Tâche 3',
              taskDescription: 'Description de la tâche 3',
              dueDate: 'Hier',
            ),
          ],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String taskTitle;
  final String taskDescription;
  final String dueDate;

  const TaskCard({super.key, 
    required this.taskTitle,
    required this.taskDescription,
    required this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(taskTitle),
        subtitle: Text(taskDescription),
        trailing: Text(
          dueDate,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: DashboardPage(),
  ));
}
