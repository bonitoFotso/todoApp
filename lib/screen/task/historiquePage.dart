import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoriquePage extends StatelessWidget {
  const HistoriquePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique'),
      ),
      body: ListView.builder(
        itemCount: _historiqueTasks.length,
        itemBuilder: (context, index) {
          final task = _historiqueTasks[index];
          return ListTile(
            leading: _buildStatusIcon(task.status),
            title: Text(task.name),
            subtitle:
                Text('Date: ${DateFormat('yyyy-MM-dd').format(task.date)}'),
            trailing: Text('Priority: ${task.priority}'),
            onTap: () {
              // Add your task detail navigation logic here
            },
          );
        },
      ),
    );
  }

  Widget _buildStatusIcon(String status) {
    switch (status) {
      case 'To Do':
        return Icon(Icons.pending_outlined, color: Colors.orange);
      case 'In Progress':
        return Icon(Icons.hourglass_empty_outlined, color: Colors.blue);
      case 'Done':
        return Icon(Icons.check_circle_outline, color: Colors.green);
      case 'Pending':
        return Icon(Icons.pending_actions_outlined, color: Colors.yellow);
      case 'Cancelled':
        return Icon(Icons.cancel_outlined, color: Colors.red);
      default:
        return Icon(Icons.error_outline);
    }
  }
}

class Task {
  final String name;
  final DateTime date;
  final String status;
  final int priority;

  Task({
    required this.name,
    required this.date,
    required this.status,
    required this.priority,
  });
}

final List<Task> _historiqueTasks = [
  Task(
      name: 'Task 1',
      date: DateTime.now().subtract(Duration(days: 5)),
      status: 'Done',
      priority: 2),
  Task(
      name: 'Task 2',
      date: DateTime.now().subtract(Duration(days: 7)),
      status: 'Cancelled',
      priority: 1),
  Task(
      name: 'Task 3',
      date: DateTime.now().subtract(Duration(days: 10)),
      status: 'To Do',
      priority: 3),
  Task(
      name: 'Task 4',
      date: DateTime.now().subtract(Duration(days: 15)),
      status: 'In Progress',
      priority: 2),
  Task(
      name: 'Task 5',
      date: DateTime.now().subtract(Duration(days: 20)),
      status: 'Done',
      priority: 1),
];
