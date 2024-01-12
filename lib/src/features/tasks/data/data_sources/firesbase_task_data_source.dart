import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hometasks/src/core/errors/error_type.dart';
import 'package:hometasks/src/core/errors/task/task_error.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/data/repositories/task_remote_data_source.dart';
import 'package:hometasks/src/features/tasks/data/models/task_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';


class FirebaseTaskDataSource implements TaskDataSource {
  final FirebaseFirestore firestore;

  FirebaseTaskDataSource({required this.firestore});
  //params - all the params needed for pagination see GetTaskParams Class for detailed explanation
  // @override
  // Future<Result<List<TaskModel>>> getTasks(GetTaskParams params) async {
  //   try {
  //     Query query = firestore.collection('tasks');
  //     // Apply sorting
  //     if (params!.orderByField != null) {
  //       query = query.orderBy(params!.orderByField!, descending: params!.descending!);
  //     }
  //
  //     // Apply pagination
  //     if (params!.currentPageToken != null) {
  //       final lastDocument = await firestore.collection('tasks').doc(params!.currentPageToken).get();
  //       query = query.startAfterDocument(lastDocument);
  //     }
  //
  //     // Apply limit
  //     if (params!.limit != null) {
  //       query = query.limit(params!.limit!);
  //     }
  //
  //     final tasksSnapshot = await query.get();
  //     final tasks = tasksSnapshot.docs.map((doc) => TaskModel.fromSnapshot(doc)).toList();
  //     if(tasks.isEmpty){
  //       return Result.failure(
  //         internalCode: "tasks.data.repositories.firebase.getTasks",
  //         message: "empty when fetching from firebase ",
  //         serverError: TaskError.createTaskError(ServerErrorType.emptyList),
  //       );
  //     }
  //     return Result.success(value: tasks);
  //   } catch (e) {
  //     return Result.failure(
  //       internalCode: "tasks.data.repositories.firebase.getTasks",
  //       message: "internal error when fetching from firebase",
  //       serverError: TaskError.createTaskError(ServerErrorType.internalServerError),
  //     );
  //   }
  // }
  //params - all the params needed for pagination see GetTaskParams Class for detailed explanation
  @override
  Stream<List<TaskModel>> getTasksStreamAsync(GetTaskParams params) async* {
    try {
      Query query = firestore.collection('tasks');
      // Apply sorting
      if (params.orderByField != null) {
        query =
            query.orderBy(params.orderByField!, descending: params.descending!);
      }

      // Apply pagination
      if (params.currentPageToken != null) {
        final lastDocument = await firestore.collection('tasks').doc(
            params.currentPageToken).get();
        query = query.startAfterDocument(lastDocument);
      }

      // Apply limit
      if (params.limit != null) {
        query = query.limit(params.limit!);
      }

      yield* query.snapshots().map((tasksSnapshot) {
        final tasks = tasksSnapshot.docs.map((doc) =>
            TaskModel.fromSnapshot(doc)).toList();
        if (tasks.isEmpty) {
          throw(TaskError.createTaskError(ServerErrorType.emptyList));
        }
        return tasks;
      });
    } catch (e) {
      yield throw(TaskError.createTaskError(
          ServerErrorType.internalServerError));
    }
  }

  @override
  Future<Result> addTask(TaskModel task) async {
    try {
      await firestore.collection('tasks').add(task.toDocument());
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
      await firestore.collection('tasks').doc(id).delete();
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
  Future<Result> updateTask(String taskId, Map<String, dynamic> updatedFields) async {
    try {
      final docRef = firestore.collection('tasks').doc(taskId);
      // Check if the document exists
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        return Result.failure(
          internalCode: "tasks.data.repositories.firebase.updateTask",
          message: "Document does not exist",
          serverError: TaskError.createTaskError(ServerErrorType.notFound),
        );
      }
      await docRef.update(updatedFields);
      return Result.success();
    } catch (e) {
      return Result.failure(
        internalCode: "tasks.data.repositories.firebase.updateTask",
        message: "internal error when updating in firebase",
        serverError: TaskError.createTaskError(ServerErrorType.internalServerError),
      );
    }
  }

  @override
  Future<Result<TaskModel>> getTaskById(String id) async {
    try {
      final docSnapshot = await firestore.collection('tasks').doc(id).get();

      if (!docSnapshot.exists) {
        return Result.failure(
          internalCode: "tasks.data.repositories.firebase.getTaskById",
          message: "internal error when fetching task by ID from firebase Not Found",
          serverError: TaskError.createTaskError(ServerErrorType.notFound),
        );
      }
      return Result.success(value: TaskModel.fromSnapshot(docSnapshot));

    } catch (e) {
      return Result.failure(
        internalCode: "tasks.data.repositories.firebase.getTaskById",
        message: "internal error when fetching task by ID from firebase",
        serverError: TaskError.createTaskError(ServerErrorType.internalServerError),
      );
    }
  }
}
