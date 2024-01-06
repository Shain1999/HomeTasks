import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/data/models/task_model.dart';

// all the function used on a datasource
abstract class TaskDataSource {
  Future<List<TaskModel>> getTasks(GetTaskParams params);

  Future<void> addTask(TaskModel task);

  Future<void> updateTask(TaskModel task);

  Future<void> deleteTask(TaskModel task);
}
