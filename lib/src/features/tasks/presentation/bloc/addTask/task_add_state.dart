import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';


enum TaskAddStatus { initial, loading, success, failure,error }
final class TaskAddState extends Equatable {
const TaskAddState({
this.status = TaskAddStatus.initial,
this.task,
this.errorMessage
});

final TaskAddStatus status;
final String? errorMessage;
final Task? task;



TaskAddState copyWith({
TaskAddStatus Function()? status,
Task Function()? task,
String? errorMessage
}) {
return TaskAddState(
status: status != null ? status() : this.status,
task: task != null ? task() : this.task,
errorMessage: errorMessage ?? this.errorMessage
);
}

@override
List<Object?> get props => [
status,
task,
errorMessage
];
}