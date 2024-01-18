import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/features/tasks/data/data_sources/firesbase_task_data_source.dart';
import 'package:hometasks/src/features/tasks/data/models/task_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import '../../../../helpers/test_helper.mocks.dart';


void main() {
  test('Should return success when adding a task to Firebase', () async {
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
      estimatedTime: Duration(hours: 1),
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


    // Act
    final result = await mockDataSource.addTask(taskModel);

    // Assert
    expect(result.isSuccess, true);
    expect(result.value, isNull);
    expect(result.internalCode, isNull);
    expect(result.message, isNull);
    expect(result.serverError, isNull);
  });


}
