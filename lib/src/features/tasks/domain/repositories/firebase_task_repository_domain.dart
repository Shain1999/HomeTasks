import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/update_task_params.dart';

abstract class DomainFirebaseTaskRepository {
  Stream<List<Task>> getTasksStream(GetTaskParams params);

  Future<Result> addTask(Task task);

  Future<Result> updateTask(UpdateTaskParams updateParams);

  Future<Result> deleteTask(String id);

  Future<Result<Task>> getTaskById(String id);
}