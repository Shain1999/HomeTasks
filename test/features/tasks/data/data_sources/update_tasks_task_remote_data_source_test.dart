import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/features/tasks/data/data_sources/firesbase_task_data_source.dart';
import 'package:mockito/mockito.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/core/errors/error_type.dart';
import 'package:hometasks/src/core/errors/task/task_error.dart';
import 'package:hometasks/src/features/tasks/data/models/task_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';


void main() {
  test('Should return success when updating a task in Firebase', () async {
    // Arrange
    final fakeFirestore = FakeFirebaseFirestore();
    final mockDataSource = FirebaseTaskDataSource(firestore: fakeFirestore);
    final taskModel = TaskModel(
      id: '1',
      title: 'Test Task',
      description: 'Task Description',
      isCompleted: false,
      dueDate: DateTime.now(),
      createdOn: DateTime.now(),
      modifiedOn: DateTime.now(),
      estimatedTime: DateTime.now(),
      assignedUserUids: ['user1', 'user2'],
      completedByUserUids: ['user3', 'user4'],
      notes: ['Note 1', 'Note 2'],
      comments: ['Comment 1', 'Comment 2'],
      score: 10,
      category: TaskCategory.shopping,
      reccuring: TaskReccuring.weekly,
      priority: TaskPriority.high,
      reminders: TaskReminders.daily,
    );
    final taskId = '1';
    final updatedFields = {'title': 'Updated Task'};

    // Act
    await fakeFirestore.collection('tasks').doc('1').set(taskModel.toDocument());

    final result = await mockDataSource.updateTask(taskId, updatedFields);

    // Assert
    expect(result.isSuccess, true);
    expect(result.value, isNull);
    expect(result.internalCode, isNull);
    expect(result.message, isNull);
    expect(result.serverError, isNull);
  });
  test('Should return failure not found when updating a non existed task in Firebase', () async {
    // Arrange
    final fakeFirestore = FakeFirebaseFirestore();
    final mockDataSource = FirebaseTaskDataSource(firestore: fakeFirestore);
    final taskId = '1';
    final updatedFields = {'title': 'Updated Task'};

    // Act

    final result = await mockDataSource.updateTask(taskId, updatedFields);

    // Assert
    expect(result.isSuccess, false);
    expect(result.value, isNull);
    expect(result.internalCode, "tasks.data.repositories.firebase.updateTask");
    expect(result.message, "Document does not exist");
    expect(result.serverError?.type, ServerErrorType.notFound);
  });


}
