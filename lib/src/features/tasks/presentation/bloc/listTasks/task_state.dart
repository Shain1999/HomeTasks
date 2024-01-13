import 'package:equatable/equatable.dart';
import 'package:hometasks/src/core/response/response.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/presentation/filters/task_view_filter.dart';

// abstract class TaskState extends Equatable{
//   const TaskState();
//
//   @override
//   List<Object?> get props =>[];
// }
// //init
// class TaskEmpty extends TaskState{}
// //loading
// class TaskLoading extends TaskState{}
// //loaded task
// class TaskLoaded extends TaskState{
//   final Task task;
//   const TaskLoaded(this.task);
//
//   List<Object?> get props =>[task];
// }
// class TaskLoadFailure extends TaskState{
//   final Response<Task> response;
//   const TaskLoadFailure(this.response);
//
//   List<Object?> get props =>[response];
// }
//
// /////////////// TASK LIST //////////////
// class TasksListLoaded extends TaskState{
//   final List<Task> taskList;
//   const TasksListLoaded(this.taskList);
//
//   List<Object?> get props =>[taskList];
// }
// class TasksListLoadFailure extends TaskState{
//   final Response<List<Task>> response;
//   const TasksListLoadFailure(this.response);
//
//   List<Object?> get props =>[response];
//
// }
// /////////////SINGLE TASK /////////////////
// class TaskAdded extends TaskState {
//   final Task task;
//   const TaskAdded(this.task);
//
//   List<Object?> get props => [task];
// }
//
//
// ////////////////TASK UPDATING/////////////////
// class TaskUpdateLoading extends TaskState {}
//
// class TaskUpdated extends TaskState {
//   final Task task;
//   const TaskUpdated(this.task);
//
//   List<Object?> get props => [task];
// }
// class TaskUpdateFailure extends TaskState{
//   final Response response;
//   const TaskUpdateFailure(this.response);
//
//   List<Object?> get props =>[response];
// }
//
//
// ////////TASK DELETING////////////////////////////
// class TaskDeleteLoading extends TaskState {}
//
// class TaskDeleted extends TaskState {}
//
// class TaskDeleteFailure extends TaskState{
//   final Response response;
//   const TaskDeleteFailure(this.response);
//
//   List<Object?> get props =>[response];
// }
// /////////////TASK GET BY ID /////////////////////
// class TaskGetByIdLoading extends TaskState {}
//
// class TaskGetByIdLoaded extends TaskState {
//   final Task task;
//   const TaskGetByIdLoaded(this.task);
//
//   List<Object?> get props => [task];
// }
// class TaskGetByIdFailure extends TaskState {
//   final Response<Task> response;
//   const TaskGetByIdFailure(this.response);
//
//   List<Object?> get props => [response];
// }


enum TasksViewStatus { initial, loading, success, failure }
final class TasksViewState extends Equatable {
  const TasksViewState({
    this.status = TasksViewStatus.initial,
    this.tasks = const [],
    this.getTasksParams = const GetTaskParams(),
    this.filter = TaskViewFilter.all,
    this.lastDeletedTask,
    this.errorMessage
  });

  final TasksViewStatus status;
  final GetTaskParams getTasksParams;
  final String? errorMessage;
  final List<Task> tasks;
  final TaskViewFilter filter;
  final Task? lastDeletedTask;

  Iterable<Task> get filteredTodos => filter.applyAll(tasks);

  TasksViewState copyWith({
    TasksViewStatus Function()? status,
    List<Task> Function()? tasks,
    TaskViewFilter Function()? filter,
    Task? Function()? lastDeletedTask,
    String? errorMessage
  }) {
    return TasksViewState(
      status: status != null ? status() : this.status,
      tasks: tasks != null ? tasks() : this.tasks,
      filter: filter != null ? filter() : this.filter,
      lastDeletedTask:
      lastDeletedTask != null ? lastDeletedTask() : this.lastDeletedTask,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [
    status,
    tasks,
    filter,
    lastDeletedTask,
    errorMessage
  ];
}