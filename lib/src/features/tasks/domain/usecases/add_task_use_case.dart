import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/core/response/response.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/repositories/firebase_task_repository_domain.dart';

class AddTaskUseCase {
  final DomainFirebaseTaskRepository repository;

  AddTaskUseCase({required this.repository});

  Future<Response<Task>> handle(Task task) async {
    try {
      Result result = await repository.addTask(task);
      if (!result.isSuccess) {
        return Response<Task>.internalError(
            message: "Failed to add task", internalCode: result.internalCode);
      }
      return Response<Task>.ok(message: "Task added successfully");
    } catch (e) {
      return Response<Task>.internalError(
          message: "Failed to add task", internalCode: "addTaskFailure");
    }
  }
}