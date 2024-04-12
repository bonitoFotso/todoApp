import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/models/DatabaseProvider.dart';
import 'package:todo/services/task/TaskProvider.dart';

class TaskDetailsTab extends StatelessWidget {
  const TaskDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        Task task = taskProvider.task;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Name', task.name),
            _buildDetailRow('Creation Date', task.creationDate),
            _buildDetailRow('Is Ok', task.isOk.toString()),
            _buildDetailRow('Modification Date', task.modificationDate),
            _buildDetailRow('Detail', task.detail),
            _buildDetailRow('User ID', task.userId.toString()),
            _buildDetailRow('Group ID', task.groupId.toString()),
            _buildDetailRow('Priority', task.priority.toString()),
            _buildDetailRow('Status', task.status),
            const SizedBox(height: 16),
            const Text(
              'Action History:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<List<TaskActionHistory>>(
                future: DatabaseProvider.getTaskActionHistoryByTaskId(task.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<TaskActionHistory> historys = snapshot.data!;
                    return ListView.builder(
                      itemCount: historys.length,
                      itemBuilder: (context, index) {
                        TaskActionHistory history = historys[index];
                        return ListTile(
                          title: Text(history.action),
                          subtitle: Text(history.actionDate),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No history available'));
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    final displayValue = value ?? 'N/A'; // Use 'N/A' if value is null

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              displayValue,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
