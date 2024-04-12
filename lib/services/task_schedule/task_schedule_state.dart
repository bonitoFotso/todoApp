part of 'task_schedule_bloc.dart';

sealed class TaskScheduleState extends Equatable {
  const TaskScheduleState();
  
  @override
  List<Object> get props => [];
}

final class TaskScheduleInitial extends TaskScheduleState {}
