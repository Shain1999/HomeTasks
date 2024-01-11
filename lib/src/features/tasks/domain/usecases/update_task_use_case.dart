import 'package:hometasks/src/core/response/response.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/domain/entities/update_task_params.dart';
import 'package:hometasks/src/features/tasks/domain/repositories/firebase_task_repository_domain.dart';

class UpdateTaskUseCase {
  final DomainFirebaseTaskRepository repository;

  UpdateTaskUseCase({required this.repository});

  Future<Response> handle(UpdateTaskParams updateParams) async {
    try {
      Result result = await repository.updateTask(updateParams);
      if (!result.isSuccess) {
        return Response.internalError(
            message: "Failed to update task",
            internalCode: result.internalCode);
      }
      return Response.ok(message: "Task updated successfully");
    } catch (e) {
      return Response.internalError(
          message: "Failed to update task", internalCode: "updateTaskFailure");
    }
  }
}