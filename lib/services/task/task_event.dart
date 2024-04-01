part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class FetchTasks extends TaskEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AddTaskEvent extends TaskEvent {
  final Task task;

  AddTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends TaskEvent {
  final Task updatedTask;

  UpdateTaskEvent(this.updatedTask);

  @override
  List<Object> get props => [updatedTask];
}

class DeleteTaskEvent extends TaskEvent {
  final int index;

  DeleteTaskEvent(this.index);

  @override
  List<Object> get props => [index];
}

class LoadTasks extends TaskEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
