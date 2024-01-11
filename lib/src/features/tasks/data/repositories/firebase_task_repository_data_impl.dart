import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/data/data_sources/firestone_task_data_source.dart';
import 'package:hometasks/src/features/tasks/data/models/task_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/repositories/firebase_task_repository.dart';

class FirebaseTaskRepositoryImpl implements FirebaseTaskRepository{

  final FirebaseTaskDataSource _firebaseTaskDataSource;

  FirebaseTaskRepositoryImpl(this._firebaseTaskDataSource);

  @override
  Future<Result> addTask(Task task) async {
    try{
      await _firebaseTaskDataSource.addTask(task.toModel());
      return Result.success();
    }catch(e){
      return Result.failure(internalCode: "tasks.data.repositories.firebase.addTask",message: "internal error when creating in firebase");
    }
  }
  @override
  Future<Result> deleteTask(Task task) async {
    try{
      await _firebaseTaskDataSource.deleteTask(task.toModel());
      return Result.success();
    }catch(e){
      return Result.failure(internalCode: "tasks.data.repositories.firebase.deleteTask",message: "internal error when delete from firebase");
    }
  }

  @override
  Future<Result<List<Task>>> getTasks(GetTaskParams params) async {
    try{
      Result<List<TaskModel>> taskModelResponse = await _firebaseTaskDataSource.getTasks(params);
      if(!taskModelResponse.isSuccess){
        return Result.failure(message: taskModelResponse.message,internalCode: taskModelResponse.internalCode);
      }
      List<Task> taskList=taskModelResponse.value!.map((model)=>model.toEntity()).toList();
      return Result.success(value: taskList);
    }catch(e){
      return Result.failure(internalCode: "tasks.data.repositories.firebase.getTasks",message: "internal error when fetching from firebase");
    }
  }

  @override
  Future<Result> updateTask(Task task) async {
    try {
      await _firebaseTaskDataSource.updateTask(task.toModel());
      return Result.success();
    } catch (e) {
      return Result.failure(
          internalCode: "tasks.data.repositories.firebase.updateTask",
          message: "internal error when updating in firebase");
    }
  }

  @override
  Future<Result<Task>> getTaskById(String id) async {
    try {
      Result<TaskModel> taskModel = await _firebaseTaskDataSource.getTaskById(id);
      if (taskModel.isSuccess) {
        Task task = taskModel.value!.toEntity();
        return Result.success(value: task);
      } else {
        final errorMessage = taskModel.message;
        return Result.failure(message: "Task with ID $id not found \n $errorMessage",internalCode: taskModel.internalCode);
      }
    } catch (e) {
      return Result.failure(
          internalCode: "tasks.data.repositories.firebase.getTaskById ",
          message: "internal error when fetching task by ID from firebase \n");
    }
  }

}