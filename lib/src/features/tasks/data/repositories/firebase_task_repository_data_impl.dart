import 'package:hometasks/src/core/errors/error_type.dart';
import 'package:hometasks/src/core/errors/task/task_error.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/data/repositories/task_remote_data_source.dart';
import 'package:hometasks/src/features/tasks/data/models/task_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/update_task_params.dart';
import 'package:hometasks/src/features/tasks/domain/repositories/firebase_task_repository_domain.dart';

class DataFirebaseTaskRepositoryImpl implements DomainFirebaseTaskRepository {
  final TaskDataSource _taskDataSource;

  DataFirebaseTaskRepositoryImpl(this._taskDataSource);

  @override
  Future<Result> addTask(Task task) async {
    try {
      Result result = await _taskDataSource.addTask(task.toModel());
      if(!result.isSuccess) {
        return result;
      }
      return Result.success();
    } catch (e) {
      return Result.failure(
        internalCode: "tasks.data.repositories.firebase.addTask",
        message: "internal error when creating in firebase",
        serverError: TaskError.createTaskError(ServerErrorType.internalServerError),
      );
    }
  }

  @override
  Future<Result> deleteTask(String id) async {
    try {
      Result result =await _taskDataSource.deleteTask(id);
      if(!result.isSuccess) {
        return result;
      }
      return Result.success();
    } catch (e) {
      return Result.failure(
        internalCode: "tasks.data.repositories.firebase.deleteTask",
        message: "internal error when delete from firebase",
        serverError: TaskError.createTaskError(ServerErrorType.internalServerError),
      );
    }
  }

  @override
  Stream<List<Task>> getTasksStream(GetTaskParams params) async* {
    try {
      yield* _taskDataSource.getTasksStreamAsync(params).map((result) {
        if (result.isEmpty) {
          throw(TaskError.createTaskError(
              ServerErrorType.internalServerError));
        }
        List<Task> taskList = result.map((taskModel) =>
            taskModel.toEntity()).toList();
        return taskList;
      });
    } catch (e) {
      yield throw(TaskError.createTaskError(
          ServerErrorType.internalServerError));
    }
  }

  @override
  Future<Result> updateTask(UpdateTaskParams updateParams) async {
    try {
      Result result = await _taskDataSource.updateTask(updateParams.taskId, updateParams.updatedFields);
      if(!result.isSuccess){
        return result;
      }
      return Result.success();
    } catch (e) {
      return Result.failure(
        internalCode: "tasks.data.repositories.firebase.updateTask",
        message: "Error when updating in firebase",
        serverError: TaskError.createTaskError(ServerErrorType.internalServerError),
      );
    }
  }

  @override
  Future<Result<Task>> getTaskById(String id) async {
    try {
      Result<TaskModel> taskModelResult = await _taskDataSource.getTaskById(id);
      if (!taskModelResult.isSuccess) {
        final errorMessage = taskModelResult.message;
        return Result.failure(
          message: "Task with ID $id not found \n $errorMessage",
          internalCode: taskModelResult.internalCode,
          serverError: taskModelResult.serverError,
        );
      }
      Task task = taskModelResult.value!.toEntity();
      return Result.success(value: task);

    } catch (e) {
      return Result.failure(
        internalCode: "tasks.data.repositories.firebase.getTaskById ",
        message: "internal error when fetching task by ID from firebase \n",
        serverError: TaskError.createTaskError(ServerErrorType.internalServerError),
      );
    }
  }

}