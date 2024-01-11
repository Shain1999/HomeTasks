import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/data/data_sources/task_remote_data_source.dart';
import 'package:hometasks/src/features/tasks/data/models/task_model.dart';

import '../../domain/entities/get_task_params_model.dart';

class FirebaseTaskDataSource implements TaskDataSource {
  final FirebaseFirestore firestore;

  FirebaseTaskDataSource({required this.firestore});
  @override
  Future<Result<List<TaskModel>>> getTasks(GetTaskParams params) async {
    try {
      Query query = firestore.collection('tasks');
      // Apply sorting
      if (params!.orderByField != null) {
        query = query.orderBy(params!.orderByField!, descending: params!.descending!);
      }

      // Apply pagination
      if (params!.currentPageToken != null) {
        final lastDocument = await firestore.collection('tasks').doc(params!.currentPageToken).get();
        query = query.startAfterDocument(lastDocument);
      }

      // Apply limit
      if (params!.limit != null) {
        query = query.limit(params!.limit!);
      }

      final tasksSnapshot = await query.get();
      final tasks = tasksSnapshot.docs.map((doc) => TaskModel.fromSnapshot(doc)).toList();

      return Result.success(value: tasks);
    } catch (e) {
      return Result.failure(
        internalCode: "tasks.data.repositories.firebase.getTasks",
        message: "internal error when fetching from firebase",
      );
    }
  }

  @override
  Future<Result<void>> addTask(TaskModel task) async {
    try {
      await firestore.collection('tasks').add(task.toDocument());
      return Result.success();
    } catch (e) {
      return Result.failure(
        internalCode: "tasks.data.repositories.firebase.addTask",
        message: "internal error when creating in firebase",
      );
    }
  }

  @override
  Future<Result<void>> deleteTask(TaskModel task) async {
    try {
      await firestore.collection('tasks').doc(task.id).delete();
      return Result.success();
    } catch (e) {
      return Result.failure(
        internalCode: "tasks.data.repositories.firebase.deleteTask",
        message: "internal error when delete from firebase",
      );
    }
  }

  @override
  Future<Result<void>> updateTask(TaskModel task) async {
    try {
      await firestore.collection('tasks').doc(task.id).update(task.toDocument());
      return Result.success();
    } catch (e) {
      return Result.failure(
        internalCode: "tasks.data.repositories.firebase.updateTask",
        message: "internal error when updating in firebase",
      );
    }
  }

  @override
  Future<Result<TaskModel>> getTaskById(String id) async {
    try {
      final docSnapshot = await firestore.collection('tasks').doc(id).get();

      if (docSnapshot.exists) {
        return Result.success(value: TaskModel.fromSnapshot(docSnapshot));
      } else {
        return Result.failure(internalCode: "tasks.data.repositories.firebase.getTaskById",
          message: "internal error when fetching task by ID from firebase Not Found",);
      }
    } catch (e) {
      return Result.failure(
        internalCode: "tasks.data.repositories.firebase.getTaskById",
        message: "internal error when fetching task by ID from firebase",
      );
    }
  }
}
