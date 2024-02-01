import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_state.dart';


enum TaskEditStatus { initial, loading, success, failure,error }
final class TaskEditState extends TaskState {
const TaskEditState({
this.status = TaskStatus.initial,
this.updatedFields=const {},
this.task,
this.errorMessage
});

final TaskStatus status;
final String? errorMessage;
final Task? task;
final Map<String,dynamic> updatedFields;


TaskEditState copyWith({
  TaskStatus Function()? status,
Task Function()? task,
Map<String,dynamic> Function()? updatedFields,
String? errorMessage
}) {
return TaskEditState(
status: status != null ? status() : this.status,
task: task != null ? task() : this.task,
updatedFields: updatedFields != null ? updatedFields() : this.updatedFields,
errorMessage: errorMessage ?? this.errorMessage
);
}

@override
List<Object?> get props => [
status,
task,
updatedFields,
errorMessage
];
}