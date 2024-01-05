import 'package:hometasks/src/features/tasks/data/models/task_model.dart';

// all the function used on a datasource
abstract class TaskDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(TaskModel task);
}
