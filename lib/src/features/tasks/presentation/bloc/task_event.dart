import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/presentation/filters/task_view_filter.dart';

abstract class TaskEvent extends Equatable{
  const TaskEvent();

  @override
  List<Object?> get props => [];
}
class OnGetTasks extends TaskEvent{
  final GetTaskParams params;
  const OnGetTasks(this.params);

  @override
  List<Object?> get props => [params];
}
class OnAddTask extends TaskEvent {
  final Task task;
  const OnAddTask(this.task);

  @override
  List<Object?> get props => [task];
}

class OnUpdateTask extends TaskEvent {
  final String taskId;
  final Map<String, dynamic> updatedFields;
  final Task? taskToUpdate;
  const OnUpdateTask(this.taskId, this.updatedFields,this.taskToUpdate);

  @override
  List<Object?> get props => [taskId, updatedFields];
}

class OnDeleteTask extends TaskEvent {
  final String taskId;
  const OnDeleteTask(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class OnGetTaskById extends TaskEvent {
  final String taskId;
  const OnGetTaskById(this.taskId);

  @override
  List<Object?> get props => [taskId];
}
class OnTasksViewFilterChanged extends TaskEvent {
  const OnTasksViewFilterChanged(this.filter);

  final TaskViewFilter filter;

  @override
  List<Object> get props => [filter];
}