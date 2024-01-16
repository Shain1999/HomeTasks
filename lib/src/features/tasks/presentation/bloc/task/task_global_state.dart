import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';


enum TaskStatus { initial, loading, success, failure,error }
class TaskState  {
  const TaskState({
    this.status = TaskStatus.initial,
    this.updatedFields = const {},
    this.task,
    this.errorMessage
  });

  final TaskStatus status;
  final String? errorMessage;
  final Task? task;
  final Map<String, dynamic> updatedFields;


  TaskState copyWith({
    TaskStatus Function()? status,
    Task Function()? task,
    Map<String, dynamic> Function()? updatedFields,
    String? errorMessage
  }) {
    return TaskState(
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