import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_state.dart';


class TaskAddState extends TaskState {
  const TaskAddState({
    this.status = TaskStatus.initial,
    this.updatedFields = const {},
    this.task,
    this.errorMessage
  }):super();

  final TaskStatus status;
  final String? errorMessage;
  final Task? task;
  final Map<String, dynamic> updatedFields;


  TaskAddState copyWith({
    TaskStatus Function()? status,
    Task Function()? task,
    Map<String, dynamic> Function()? updatedFields,
    String? errorMessage
  }) {
    return TaskAddState(
      status: status != null ? status() : this.status,
      task: task != null ? task() : this.task,
      errorMessage: errorMessage ?? this.errorMessage,
      updatedFields: updatedFields != null ? updatedFields() : this
          .updatedFields,
    );
  }

  @override
  List<Object?> get props =>
      [
        status,
        task,
        updatedFields,
        errorMessage
      ];

}