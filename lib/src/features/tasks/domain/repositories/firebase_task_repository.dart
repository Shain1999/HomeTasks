import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';

abstract class FirebaseTaskRepository {
  Future<List<Task>> getTasks(GetTaskParams params);

  Future<void> addTask(Task task);

  Future<void> updateTask(Task task);

  Future<void> deleteTask(Task task);

  Future<void> assignToMe(Task task ,String uid);
}