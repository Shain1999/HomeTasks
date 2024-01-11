import 'package:hometasks/src/core/errors/error.dart';
import 'package:hometasks/src/core/errors/error_type.dart';
import 'package:hometasks/src/core/errors/task/task_error.dart';
import 'package:hometasks/src/core/response/response.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/repositories/firebase_task_repository_domain.dart';

class GetTasksUseCase {
  final DomainFirebaseTaskRepository repository;

  GetTasksUseCase({required this.repository});

  Stream<List<Task>> handle(GetTaskParams params) {
    try {
      return repository.getTasksStream(params).map((result) {
        if (result.isEmpty) {
          throw TaskError.createTaskError(
              ServerErrorType.emptyList);
        }
        List<Task> taskList = result;
        return taskList;
      });
    } catch (e) {
      throw TaskError.createTaskError(
          ServerErrorType.internalServerError);
    }
  }
}