import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/services/task/TaskProvider.dart';
import 'package:todo/services/task/task_bloc.dart';

class UpDateTaskTab extends StatefulWidget {
  //final Task? task;

  const UpDateTaskTab({Key? key}) : super(key: key);

  @override
  _UpDateTaskTabState createState() => _UpDateTaskTabState();
}

class _UpDateTaskTabState extends State<UpDateTaskTab> {
  late TextEditingController nameController;
  late TextEditingController creationDateController;
  late TextEditingController modificationDateController;
  late TextEditingController detailController;
  late TextEditingController groupIdController;
  late TextEditingController priorityController;
  late TextEditingController statusController;
  bool isOk2 = false; // État pour stocker la valeur de Is Ok

  @override
  void initState() {
    super.initState();
    // Initialisez la valeur de Is Ok
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        Task task = taskProvider.task;
        //final isOk = task.isOk;
        nameController = TextEditingController(text: task.name ?? '');
        creationDateController =
            TextEditingController(text: task.creationDate ?? '');
        modificationDateController =
            TextEditingController(text: task.modificationDate ?? '');
        detailController = TextEditingController(text: task.detail ?? '');
        groupIdController =
            TextEditingController(text: task.groupId.toString());
        priorityController =
            TextEditingController(text: task.priority.toString());
        statusController = TextEditingController(text: task.status ?? '');
        //isOk = task.isOk == 1;
        return Container(
          padding: const EdgeInsets.all(
              16), // Ajoutez un padding pour l'espace intérieur
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16), // Ajoutez un espace vertical
                TextField(
                  decoration: const InputDecoration(
                    labelText:
                        'Task Name', // Ajoutez une étiquette pour le champ
                  ),
                  controller: nameController,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText:
                        'Creation Date', // Ajoutez une étiquette pour le champ
                  ),
                  controller: creationDateController,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isOk2,
                      onChanged: (value) {
                        setState(() {
                          isOk2 = value!;
                        });
                        print(isOk2);
                      },
                    ),
                    const Text('Is Ok'),
                  ],
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText:
                        'Modification Date', // Ajoutez une étiquette pour le champ
                  ),
                  controller: modificationDateController,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Detail', // Ajoutez une étiquette pour le champ
                  ),
                  controller: detailController,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText:
                        'Group ID', // Ajoutez une étiquette pour le champ
                  ),
                  controller: groupIdController,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText:
                        'Priority', // Ajoutez une étiquette pour le champ
                  ),
                  controller: priorityController,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Status', // Ajoutez une étiquette pour le champ
                  ),
                  controller: statusController,
                ),
                // Ajoutez d'autres champs TextField ici
                const SizedBox(height: 16), // Ajoutez un espace vertical
                ElevatedButton(
                  onPressed: () {
                    final updatedTask = Task(
                      id: task.id,
                      name: nameController.text,
                      creationDate: creationDateController.text,
                      isOk: isOk2, // Convertir en entier
                      modificationDate: modificationDateController.text,
                      detail: detailController.text,
                      userId:
                          1, // Vous devrez peut-être ajuster cette valeur en fonction de vos besoins
                      groupId: int.tryParse(groupIdController.text) ?? 0,
                      priority: int.tryParse(priorityController.text) ?? 0,
                      status: statusController.text,
                    );

                    // Si la tâche existe déjà, émettez un événement pour la mettre à jour
                    context.read<TaskBloc>().add(UpdateTaskEvent(updatedTask));

                    Navigator.of(context).pop();
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
