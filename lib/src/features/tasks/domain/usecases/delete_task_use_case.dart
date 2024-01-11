import 'package:hometasks/src/core/response/response.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/repositories/firebase_task_repository_domain.dart';

class DeleteTaskUseCase {
  final DomainFirebaseTaskRepository repository;

  DeleteTaskUseCase({required this.repository});

  Future<Response> handle(String id) async {
    try {
      Result result = await repository.deleteTask(id);
      if (!result.isSuccess) {
        return Response.internalError(
            message: "Failed to delete task",
            internalCode: result.internalCode);
      }
      return Response.ok(message: "Task deleted successfully");
    } catch (e) {
      return Response.internalError(
          message: "Failed to delete task", internalCode: "deleteTaskFailure");
    }
  }
}
