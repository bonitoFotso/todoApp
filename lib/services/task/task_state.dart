part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  final List<Task> tasks;

  const TaskState(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskInitial extends TaskState {
  const TaskInitial(List<Task> tasks) : super(tasks);
}

class TaskSuccess extends TaskState {
  const TaskSuccess(List<Task> tasks) : super(tasks);
}

class TaskFailure extends TaskState {
  final String error;

  const TaskFailure(this.error) : super(error as List<Task>);

  //@override
  //List<Object> get props => [error];
}
