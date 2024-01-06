import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hometasks/src/features/tasks/data/data_sources/task_remote_data_source.dart';
import 'package:hometasks/src/features/tasks/data/models/task_model.dart';

import '../../domain/entities/get_task_params_model.dart';

class FirebaseTaskDataSource implements TaskDataSource {
  final FirebaseFirestore firestore;

  FirebaseTaskDataSource({required this.firestore});

  @override
  Future<List<TaskModel>> getTasks(
    GetTaskParams params
  ) async {
    Query query = firestore.collection('tasks');
    // Apply sorting
    if (params!.orderByField != null) {
      query = query.orderBy(params!.orderByField!, descending: params!.descending!);
    }

    //apply Pagination
    if (params!.currentPageToken != null) {
      final lastDocument =
          await firestore.collection('tasks').doc(params!.currentPageToken).get();
      query = query.startAfterDocument(lastDocument);
    }
    // Apply limit
    if (params!.limit != null) {
      query = query.limit(params!.limit!);
    }

    final tasksSnapshot = await query.get();
    final tasks =
        tasksSnapshot.docs.map((doc) => TaskModel.fromSnapshot(doc)).toList();

    return tasks;
  }

  @override
  Future<void> addTask(TaskModel task) async {
    final docRef = firestore.collection('tasks').doc();
    await docRef.set(task.toDocument());
  }

  @override
  Future<void> deleteTask(TaskModel task) async {
    final docRef = firestore.collection('tasks').doc(task.id);
    await docRef.delete();
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final docRef = firestore.collection('tasks').doc(task.id);
    await docRef.update(task.toDocument());
  }
}
