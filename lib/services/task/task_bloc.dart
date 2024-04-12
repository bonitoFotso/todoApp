import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/models/DatabaseProvider.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final DatabaseProvider databaseProvider;

  TaskBloc(this.databaseProvider)
      : super(const TaskInitial({'tasks': [], 'taskGroups': []})) {
    on<FetchTasks>(_onFetchTasks);
    on<UpdateTaskEvent>(_onUpDateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<AddTaskEvent>(_onAddTask);
    on<LoadTasks>(_onLoadTasks);
  }

  Future<void> _onFetchTasks(FetchTasks event, Emitter<TaskState> emit) async {
    try {
      final tasks = await DatabaseProvider.getTasks();
      final taskGroups = await DatabaseProvider.getTaskGroups();
      final Map<String, List<Object>> data = {
        'tasks': tasks,
        'taskGroups': taskGroups,
      };

      emit(TaskSuccess(data)); // Emit a sing
    } catch (e) {
      //emit(TaskFailure(e.toString()) as TaskState);
    }
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    final taskId = event.index;
    try {
      await databaseProvider.deleteTask(taskId);
      final tasks = await DatabaseProvider.getTasks();
      final taskGroups = await DatabaseProvider.getTaskGroups();
      final Map<String, List<Object>> data = {
        'tasks': tasks,
        'taskGroups': taskGroups,
      };

      emit(TaskSuccess(data)); // Emit a sing
    } catch (e) {
      //emit(TaskFailure(e.toString()));
    }
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    try {
      final newTask = event.task;
      await DatabaseProvider.addTask(newTask);

      // Récupérer la dernière tâche ajoutée
      final List<Task> tasks = await DatabaseProvider.getTasks();
      final Task lastTask =
          tasks.isNotEmpty ? tasks.last : throw Exception('No tasks found');

      // Créer l'historique de la dernière tâche
      final TaskActionHistory actionHistory = TaskActionHistory(
        taskId: lastTask.id!, // ID de la dernière tâche ajoutée
        action: 'Created', // Action de création
        actionDate: DateTime.now().toString(), // Date et heure actuelles
      );
      await DatabaseProvider.addTaskActionHistory(actionHistory);

      // Récupérer à nouveau les tâches et les groupes de tâches pour inclure les données mises à jour
      final updatedTasks = await DatabaseProvider.getTasks();
      final taskGroups = await DatabaseProvider.getTaskGroups();
      final Map<String, List<Object>> data = {
        'tasks': updatedTasks,
        'taskGroups': taskGroups,
      };

      emit(TaskSuccess(
          data)); // Émettre un événement avec les données mises à jour
    } catch (e) {
      emit(TaskFailure(e.toString())); // Gérer les erreurs
    }
  }

  Future<void> _onUpDateTask(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    try {
      final upTask = event.updatedTask;
      final task = await DatabaseProvider.getTasksById(upTask.id!);

      // Vérifier si la tâche a été mise à jour
      if (task.isOk != upTask.isOk) {
        // Créer un historique de la mise à jour
        final TaskActionHistory actionHistory = TaskActionHistory(
          taskId: upTask.id!, // ID de la tâche mise à jour
          action: upTask.isOk == true
              ? 'Completed'
              : 'Updated', // Action basée sur l'état de la tâche mise à jour
          actionDate: DateTime.now().toString(), // Date et heure actuelles
        );
        await DatabaseProvider.addTaskActionHistory(actionHistory);
      }

      // Mettre à jour la tâche dans la base de données
      await DatabaseProvider.updateTask(upTask);

      // Récupérer à nouveau les tâches et les groupes de tâches pour inclure les données mises à jour
      final tasks = await DatabaseProvider.getTasks();
      final taskGroups = await DatabaseProvider.getTaskGroups();
      final Map<String, List<Object>> data = {
        'tasks': tasks,
        'taskGroups': taskGroups,
      };

      // Émettre un événement avec les données mises à jour
      emit(TaskSuccess(data));
    } catch (e) {
      // Gérer les erreurs
      // emit(TaskFailure(e.toString()));
    }
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    try {
      final tasks = await DatabaseProvider.getTasks();
      final taskGroups = await DatabaseProvider.getTaskGroups();
      final Map<String, List<Object>> data = {
        'tasks': tasks,
        'taskGroups': taskGroups,
      };

      emit(TaskSuccess(
          data)); // Emit a single state containing both tasks and task groups
    } catch (e) {
      print(e.toString());
    }
  }
}
