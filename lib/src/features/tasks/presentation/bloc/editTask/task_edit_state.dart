import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';


enum TaskEditStatus { initial, loading, success, failure,error }
final class TaskEditState extends Equatable {
const TaskEditState({
this.status = TaskEditStatus.initial,
this.updatedFields=const {},
this.task,
this.errorMessage
});

final TaskEditStatus status;
final String? errorMessage;
final Task? task;
final Map<String,dynamic> updatedFields;


TaskEditState copyWith({
TaskEditStatus Function()? status,
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