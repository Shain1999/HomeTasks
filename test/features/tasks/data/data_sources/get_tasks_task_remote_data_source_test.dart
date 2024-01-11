import 'dart:async';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/core/errors/error_type.dart';
import 'package:hometasks/src/core/errors/task/task_error.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/data/data_sources/firesbase_task_data_source.dart';
import 'package:hometasks/src/features/tasks/data/models/task_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:mockito/mockito.dart';


void main() {
  test('Should return a list of TaskModels from Firebase', () async {
    // Arrange
    final fakeFirestore = FakeFirebaseFirestore();
    final dataSource = FirebaseTaskDataSource(firestore: fakeFirestore);

    final taskModelJson1 = {
      'id': '1',
      'title': 'Test Task 1',
      'description': 'Task Description 1',
      'isCompleted': true,
      'dueDate': DateTime.now().toIso8601String(),
      'createdOn': DateTime.now().toIso8601String(),
      'modifiedOn': DateTime.now().toIso8601String(),
      'estimatedTime': DateTime.now().toIso8601String(),
      'assignedUserUids': ['user1', 'user2'],
      'completedByUserUids': ['user3', 'user4'],
      'notes': ['Note 1', 'Note 2'],
      'comments': ['Comment 1', 'Comment 2'],
      'score': 10,
      'category': TaskCategory.shopping.index,
      'reccuring': TaskReccuring.weekly.index,
      'priority': TaskPriority.high.index,
      'reminders': TaskReminders.daily.index,
    };


    final taskModelJson2 = {
      'id': '2',
      'title': 'Test Task 2',
      'description': 'Task Description 2',
      'isCompleted': false,
      'dueDate': DateTime.now().add(Duration(days: 5)).toIso8601String(),
      'createdOn': DateTime.now().add(Duration(days: -2)).toIso8601String(),
      'modifiedOn': DateTime.now().toIso8601String(),
      'estimatedTime': DateTime.now().add(Duration(hours: 3)).toIso8601String(),
      'assignedUserUids': ['user2', 'user3'],
      'completedByUserUids': [],
      'notes': ['Note 3', 'Note 4'],
      'comments': ['Comment 3', 'Comment 4'],
      'score': 8,
      'category': TaskCategory.shopping.index,
      'reccuring': TaskReccuring.none.index,
      'priority': TaskPriority.medium.index,
      'reminders': TaskReminders.weekly.index,
    };

    await fakeFirestore.collection('tasks').doc('1').set(taskModelJson1);
    await fakeFirestore.collection('tasks').doc('2').set(taskModelJson2);

    final params = GetTaskParams(
      orderByField: 'title',
      descending: false,
      currentPageToken: null,
      limit: 10,
    );

    // Act
    final stream = dataSource.getTasksStreamAsync(params);
    // Assert
    final streamController = StreamController<List<TaskModel>>();
    streamController.addStream(stream);

    // Wait for the stream to emit values
    await expectLater(
      streamController.stream,
      emitsInOrder([
        isA<List<TaskModel>>(),
      ]),
    );

    // Close the stream controller
    streamController.close();
  });
  /////////////////////////////////////////////////

  test('Should return a failure result when list is empty', () async {
    // Arrange
    final fakeFirestore = FakeFirebaseFirestore();
    final dataSource = FirebaseTaskDataSource(firestore: fakeFirestore);

    final params = GetTaskParams(
      orderByField: 'title',
      descending: false,
      currentPageToken: null,
      limit: 10,
    );

    // Act
    final stream = dataSource.getTasksStreamAsync(params);
    // Assert
    final streamController = StreamController<List<TaskModel>>();
    streamController.addStream(stream);

    // Wait for the stream to emit values
    await expectLater(
      streamController.stream.first,
        throwsA(isA<TaskError>()),
    );

    // Close the stream controller
    streamController.close();
  });
}
