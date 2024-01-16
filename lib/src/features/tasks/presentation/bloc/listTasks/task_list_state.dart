import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/presentation/filters/task_view_filter.dart';


enum TasksViewStatus { initial, loading, success, failure }
class TasksListState extends Equatable {
  const TasksListState({
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

  TasksListState copyWith({
    TasksViewStatus Function()? status,
    List<Task> Function()? tasks,
    TaskViewFilter Function()? filter,
    Task? Function()? lastDeletedTask,
    String? errorMessage
  }) {
    return TasksListState(
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