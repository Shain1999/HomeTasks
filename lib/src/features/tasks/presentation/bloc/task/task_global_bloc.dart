import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_state.dart';
abstract class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() :super(const TaskState()) {
    on<OnInitEvent>(OnInitFunc);
    on<OnFormSubmitEvent>(OnFormSubmitFunc);
    on<OnFieldChangedEvent>(OnFieldChangedFunc);
  }

  @override
  Future<void> close() {
    // Close any resources here

    // Close the stream
    return super.close();
  }

  Future<void> OnInitFunc(OnInitEvent event, Emitter<TaskState> emit);

  Future<void> OnFormSubmitFunc(OnFormSubmitEvent event,
      Emitter<TaskState> emit);

  Future<void> OnFieldChangedFunc(OnFieldChangedEvent event,
      Emitter<TaskState> emit);
}
