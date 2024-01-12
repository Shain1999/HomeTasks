import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/update_task_params.dart';
import 'package:hometasks/src/features/tasks/domain/repositories/firebase_task_repository_domain.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/delete_task_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/get_task_by_id_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/get_tasks_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/tasks_use_cases.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/update_task_use_case.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task_state.dart';

// class TaskBloc extends Bloc<TaskEvent,TaskState> {
//   final GetTasksUseCase _getTasksUseCase;
//
//   TaskBloc(this._getTasksUseCase) :super(TaskEmpty()) {
//     on<OnGetTasks>(
//             (event, emit) async {
//         emit(TaskLoading());
//         final response = await _getTasksUseCase.handle(event.params);
//         if(!response.isSuccess){
//           emit(TasksListLoadFailure(response));
//           return;
//         }
//         emit(TasksListLoaded(response.value!));
//         }
//     );
//   }
//
// }
// class TaskBloc extends Bloc<TaskEvent, TaskState> {
//   final GetTasksUseCase _getTasksUseCase;
//   final AddTaskUseCase _addTaskUseCase;
//   final UpdateTaskUseCase _updateTaskUseCase;
//   final DeleteTaskUseCase _deleteTaskUseCase;
//   final GetTaskByIdUseCase _getTaskByIdUseCase;
//
//   TaskBloc(
//       this._getTasksUseCase,
//       this._addTaskUseCase,
//       this._updateTaskUseCase,
//       this._deleteTaskUseCase,
//       this._getTaskByIdUseCase,
//       ) : super(TaskEmpty()) {
//     on<OnGetTasks>(
//           (event, emit) async {
//         emit(TaskLoading());
//         _getTasksUseCase.handle(event.params).listen((response) {
//           if (!response.isSuccess) {
//             emit(TasksListLoadFailure(response));
//             return;
//           }
//           emit(TasksListLoaded(response.value!));
//         });
//       },
//     );
//
//     on<OnAddTask>(
//           (event, emit) async {
//         emit(TaskLoading());
//         final response = await _addTaskUseCase.handle(event.task);
//         if (!response.isSuccess) {
//           emit(TaskLoadFailure(response));
//           return;
//         }
//         emit(TaskAdded(response.value!));
//       },
//     );
//
//     on<OnUpdateTask>(
//           (event, emit) async {
//         emit(TaskLoading());
//         UpdateTaskParams updateTaskParams = UpdateTaskParams.createUpdateTaskParams(event.taskToUpdate!, event.updatedFields);
//         final response = await _updateTaskUseCase.handle(updateTaskParams
//         );
//         if (!response.isSuccess) {
//           emit(TaskUpdateFailure(response));
//           return;
//         }
//         emit(TaskUpdated(response.value));
//       },
//     );
//
//     on<OnDeleteTask>(
//           (event, emit) async {
//         emit(TaskLoading());
//         final response = await _deleteTaskUseCase.handle(event.taskId);
//         if (!response.isSuccess) {
//           emit(TaskDeleteFailure(response));
//           return;
//         }
//         emit(TaskDeleted());
//       },
//     );
//
//     on<OnGetTaskById>(
//           (event, emit) async {
//         emit(TaskLoading());
//         final response = await _getTaskByIdUseCase.handle(event.taskId);
//         if (!response.isSuccess) {
//           emit(TaskLoadFailure(response));
//           return;
//         }
//         emit(TaskLoaded(response.value!));
//       },
//     );
//   }
// }

class TaskViewBloc extends Bloc<TaskEvent,TasksViewState> {
  TaskViewBloc({
    required DomainFirebaseTaskRepository taskRepository,
    required TaskUseCases taskUseCases,
  })
      : _taskRepository = taskRepository,
        _taskUseCases=taskUseCases,
        super(const TasksViewState()) {
    on<OnGetTasks>(_onGetTasks);
    on<OnAddTask>(_onAddTask);
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

  final DomainFirebaseTaskRepository _taskRepository;
  final TaskUseCases _taskUseCases;

  Future<void> _onAddTask(OnAddTask event,
      Emitter<TasksViewState> emit) async {
    emit(state.copyWith(status: ()=>TasksViewStatus.loading));
    final response = await _taskUseCases.addTask.handle(event.task);
    if(!response.isSuccess){
      emit(state.copyWith(status: ()=>TasksViewStatus.failure,errorMessage: response.message));
      return;
    }
    emit(state.copyWith(status: ()=>TasksViewStatus.success));
  }

  Future<void> _onGetTasks(OnGetTasks event,
      Emitter<TasksViewState> emit) async {
    emit(state.copyWith(status: () => TasksViewStatus.loading));

    await emit.forEach<List<Task>>(
      _taskUseCases.getTasks.handle(event.params),
      onData: (tasks)=>state.copyWith(
        status: ()=>TasksViewStatus.success,
        tasks: ()=>tasks
      ),
      onError: (_,__)=>state.copyWith(status: ()=>TasksViewStatus.failure,errorMessage: "Failed to fetch tasks")
    );
  }
  Future<void> _onUpdateTask(OnUpdateTask event,
      Emitter<TasksViewState> emit) async {
    emit(state.copyWith(status: ()=>TasksViewStatus.loading));

    final response = await _taskUseCases.updateTask.handle(UpdateTaskParams.createUpdateTaskParams(event.taskToUpdate!, event.updatedFields));
    if(!response.isSuccess){
      emit(state.copyWith(status: ()=>TasksViewStatus.failure,errorMessage: response.message));
      return;
    }
    emit(state.copyWith(status: ()=>TasksViewStatus.success));

  }
  Future<void> _onDeleteTask(OnDeleteTask event,
      Emitter<TasksViewState> emit) async {
    emit(state.copyWith(status: ()=>TasksViewStatus.loading));

    final response = await _taskUseCases.deleteTask.handle(event.taskId);
    if(!response.isSuccess){
      emit(state.copyWith(status: ()=>TasksViewStatus.failure,errorMessage: response.message));
      return;
    }
    emit(state.copyWith(status: ()=>TasksViewStatus.success));

  }
  void _onFilterChanged(OnTasksViewFilterChanged event,
      Emitter<TasksViewState> emit) {
    emit(state.copyWith(filter: () => event.filter));
  }
}
