import 'package:hometasks/src/core/response/response.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/repositories/firebase_task_repository_domain.dart';

class GetTaskByIdUseCase {
  final DomainFirebaseTaskRepository repository;

  GetTaskByIdUseCase({required this.repository});

  Future<Response<Task>> handle(String id) async {
    try {
      Result<Task> result = await repository.getTaskById(id);
      if (!result.isSuccess) {
        return Response<Task>.internalError(
            message: "Failed to fetch task", internalCode: result.internalCode);
      }
      return Response<Task>.ok(
          value: result.value, message: "Task fetched successfully");
    } catch (e) {
      return Response<Task>.internalError(
          message: "Failed to fetch task", internalCode: "getTaskByIdFailure");
    }
  }
}
