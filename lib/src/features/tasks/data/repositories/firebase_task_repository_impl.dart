import 'package:hometasks/src/features/tasks/data/data_sources/firestone_task_data_source.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/repositories/firebase_task_repository.dart';

class FirebaseTaskRepositoryIml implements FirebaseTaskRepository{

  final FirebaseTaskDataSource _firebaseTaskDataSource;

  FirebaseTaskRepositoryIml(this._firebaseTaskDataSource);

  @override
  Future<void> addTask(Task task) async {
    // TODO: implement addTask
    return await _firebaseTaskDataSource.addTask();
  }

  @override
  Future<void> assignToMe(Task task, String uid) async {
    // TODO: implement assignToMe
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(Task task) async {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getTasks(GetTaskParams params) async {
    // TODO: implement getTasks
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(Task task) async  {
    // TODO: implement updateTask
    throw UnimplementedError();
  }

}