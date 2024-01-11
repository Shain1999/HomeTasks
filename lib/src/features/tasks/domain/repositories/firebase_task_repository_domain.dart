import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';

abstract class DomainFirebaseTaskRepository {
  Future<Result<List<Task>>> getTasks(GetTaskParams params);

  Future<Result> addTask(Task task);

  Future<Result> updateTask(Task task);

  Future<Result> deleteTask(Task task);

  Future<Result<Task>> getTaskById(String id);
}