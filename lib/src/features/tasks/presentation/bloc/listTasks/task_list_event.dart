import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/presentation/filters/task_view_filter.dart';

abstract class TaskListEvent extends Equatable{
  const TaskListEvent();

  @override
  List<Object?> get props => [];
}
class OnGetTasks extends TaskListEvent{

  const OnGetTasks();

  @override
  List<Object?> get props => [];
}
class OnAddTask extends TaskListEvent {
  final Task task;
  const OnAddTask(this.task);

  @override
  List<Object?> get props => [task];
}

class OnUpdateTask extends TaskListEvent {
  final String taskId;
  final Map<String, dynamic> updatedFields;
  final Task? taskToUpdate;
  const OnUpdateTask({required this.taskId,  required this.updatedFields,this.taskToUpdate});

  @override
  List<Object?> get props => [taskId, updatedFields,taskToUpdate];
}

class OnDeleteTask extends TaskListEvent {
  final String taskId;
  const OnDeleteTask(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class OnGetTaskById extends TaskListEvent {
  final String taskId;
  const OnGetTaskById(this.taskId);

  @override
  List<Object?> get props => [taskId];
}
class OnTasksViewFilterChanged extends TaskListEvent {
  const OnTasksViewFilterChanged(this.filter);

  final TaskViewFilter filter;

  @override
  List<Object> get props => [filter];
}
