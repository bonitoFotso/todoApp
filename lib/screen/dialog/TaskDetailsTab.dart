import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/services/task/TaskProvider.dart';

class TaskDetailsTab extends StatelessWidget {
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
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
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
