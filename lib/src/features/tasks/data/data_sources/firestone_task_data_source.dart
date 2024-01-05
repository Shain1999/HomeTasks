import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hometasks/src/features/tasks/data/data_sources/task_remote_data_source.dart';
import 'package:hometasks/src/features/tasks/data/models/task_model.dart';

class FirestoreTaskDataSource implements TaskDataSource {
  final FirebaseFirestore firestore;

  FirestoreTaskDataSource({required this.firestore});

  @override
  Future<List<TaskModel>> getTasks({
    int? limit,
    String? currentPageToken,
    String? orderByField = 'createdOn',
    bool descending = false,
  }) async {
    Query query = firestore.collection('tasks');
    // Apply sorting
    if (orderByField != null) {
      query = query.orderBy(orderByField, descending: descending);
    }

    //apply Pagination
    if (currentPageToken != null) {
      final lastDocument =
          await firestore.collection('tasks').doc(currentPageToken).get();
      query = query.startAfterDocument(lastDocument);
    }
    // Apply limit
    if (limit != null) {
      query = query.limit(limit);
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
