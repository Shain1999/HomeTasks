import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/update_task_params.dart';
import 'package:hometasks/src/features/tasks/domain/repositories/firebase_task_repository_domain.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/tasks_use_cases.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/listTasks/task_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/listTasks/task_state.dart';

class TaskListBloc extends Bloc<TaskEvent,TasksViewState> {
  TaskListBloc({

    required TaskUseCases taskUseCases,
  })
      :
        _taskUseCases=taskUseCases,
        super(const TasksViewState()) {
    on<OnGetTasks>(_onGetTasks);

    on<OnDeleteTask>(_onDeleteTask);
    on<OnUpdateTask>(_onUpdateTask);
    on<OnTasksViewFilterChanged>(_onFilterChanged);
  }

  @override
  Future<void> close() {
    // Close any resources here

    // Close the stream
    return super.close();
  }

  final TaskUseCases _taskUseCases;

  Future<void> _onGetTasks(OnGetTasks event,
      Emitter<TasksViewState> emit) async {
    emit(state.copyWith(status: () => TasksViewStatus.loading));

    await emit.forEach<List<Task>>(
        _taskUseCases.getTasks.handle(state.getTasksParams),
        onData: (tasks) =>
            state.copyWith(
                status: () => TasksViewStatus.success,
                tasks: () => tasks
            ),
        onError: (_, __) =>
            state.copyWith(status: () => TasksViewStatus.failure,
                errorMessage: "Failed to fetch tasks")
    );
  }

  Future<void> _onUpdateTask(OnUpdateTask event,
      Emitter<TasksViewState> emit) async {
    emit(state.copyWith(status: () => TasksViewStatus.loading));

    final response = await _taskUseCases.updateTask.handle(
        UpdateTaskParams.createUpdateTaskParams(
            event.taskToUpdate!, event.updatedFields));
    if (!response.isSuccess) {
      emit(state.copyWith(status: () => TasksViewStatus.failure,
          errorMessage: response.message));
      return;
    }
    emit(state.copyWith(status: () => TasksViewStatus.success));
  }

  Future<void> _onDeleteTask(OnDeleteTask event,
      Emitter<TasksViewState> emit) async {
    emit(state.copyWith(status: () => TasksViewStatus.loading));

    final response = await _taskUseCases.deleteTask.handle(event.taskId);
    if (!response.isSuccess) {
      emit(state.copyWith(status: () => TasksViewStatus.failure,
          errorMessage: response.message));
      return;
    }
    emit(state.copyWith(status: () => TasksViewStatus.success));
  }

  Future<void> _onFilterChanged(OnTasksViewFilterChanged event,
      Emitter<TasksViewState> emit) async {
    emit(state.copyWith(filter: () => event.filter));
  }


}
