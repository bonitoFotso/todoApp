import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/screen/dialog/TaskDetailsTab.dart';
import 'package:todo/screen/dialog/UpDateTaskTab.dart';
import 'package:todo/services/task/TaskProvider.dart';

class TaskDetailPage extends StatefulWidget {
  final Task task;
  final List<TaskGroup> taskGroups;
  const TaskDetailPage({
    Key? key,
    required this.task,
    required this.taskGroups,
  }) : super(key: key);

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage>
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
          TaskProvider(widget.task), // Provide the initial state of the task
      child: Scaffold(
        appBar: AppBar(
          title: Text('Task Details'),
        ),
        body: Column(
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
                  // Tab for the general details of the task
                  TaskDetailsTab(),
                  // Tab for updating the task
                  UpDateTaskTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
