import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/data/models/task_model.dart';

// all the function used on a datasource
abstract class TaskDataSource {
  Future<Result<List<TaskModel>>> getTasks(GetTaskParams params);

  Future<Result> addTask(TaskModel task);

  Future<Result> updateTask(String taskId, Map<String, dynamic> updatedFields);

  Future<Result> deleteTask(String id);

  Future<Result<TaskModel>> getTaskById(String id);
}
