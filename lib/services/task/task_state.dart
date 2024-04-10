part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  final Map<String, List<Object>> data;

  const TaskState(this.data);

  @override
  List<Object> get props => [data];
}

class TaskInitial extends TaskState {
  const TaskInitial(Map<String, List<Object>> data) : super(data);
}

class TaskSuccess extends TaskState {
  final Map<String, List<Object>> data;

  const TaskSuccess(this.data) : super(data);
}

class TaskFailure extends TaskState {
  final String error;

  const TaskFailure(this.error) : super(error as Map<String, List<Object>>);

  //@override
  //List<Object> get props => [error];
}
