import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/screen/dialog/TaskDetailsTab.dart';
import 'package:todo/screen/dialog/UpDateTaskTab.dart';
import 'package:todo/services/task/TaskProvider.dart';

class TaskDetailDialog extends StatefulWidget {
  final Task task;
  final List<TaskGroup> taskGroups;
  const TaskDetailDialog({
    Key? key,
    required this.task,
    required this.taskGroups,
  }) : super(key: key);

  @override
  _TaskDetailDialogState createState() => _TaskDetailDialogState();
}

class _TaskDetailDialogState extends State<TaskDetailDialog>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          TaskProvider(widget.task), // Fournir l'état initial de la tâche
      child: AlertDialog(
        title: Text('Task Details'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Details'),
                Tab(text: 'Modifier'),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Onglet pour les détails généraux de la tâche
                  TaskDetailsTab(),
                  // Onglet pour modifier la tâche
                  UpDateTaskTab(),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
