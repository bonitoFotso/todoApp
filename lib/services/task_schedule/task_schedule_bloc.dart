import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_schedule_event.dart';
part 'task_schedule_state.dart';

class TaskScheduleBloc extends Bloc<TaskScheduleEvent, TaskScheduleState> {
  TaskScheduleBloc() : super(TaskScheduleInitial()) {
    on<TaskScheduleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
