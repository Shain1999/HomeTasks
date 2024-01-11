import 'package:hometasks/src/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/delete_task_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/get_task_by_id_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/get_tasks_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/update_task_use_case.dart';

class TaskUseCases {
  final GetTasksUseCase getTasks;
  final AddTaskUseCase addTask;
  final UpdateTaskUseCase updateTask;
  final DeleteTaskUseCase deleteTask;
  final GetTaskByIdUseCase getTaskById;

  TaskUseCases({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
    required this.getTaskById,
  });
}