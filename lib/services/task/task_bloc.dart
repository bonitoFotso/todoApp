import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/models/DataClass.dart';
import 'package:todo/models/DatabaseProvider.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final DatabaseProvider databaseProvider;

  TaskBloc(this.databaseProvider)
      : super(TaskInitial({'tasks': [], 'taskGroups': []})) {
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

  Future<void> _onUpDateTask(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    try {
      final upTask = event.updatedTask;
      await DatabaseProvider.updateTask(upTask);
      final tasks = await DatabaseProvider.getTasks();
      final taskGroups = await DatabaseProvider.getTaskGroups();
      final Map<String, List<Object>> data = {
        'tasks': tasks,
        'taskGroups': taskGroups,
      };
      emit(TaskSuccess(data));
    } catch (e) {
      //emit(TaskFailure(e.toString()));
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
