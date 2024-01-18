import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/features/tasks/data/models/task_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart' as Description;
import 'package:hometasks/src/features/tasks/domain/valueObjects/score/score.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';

void main() {
  test('Should return a valid model from Firebase document', () async {
    // Arrange
    final taskModelJson = {
      'id': '1',
      'title': 'Test Task',
      'description': 'Task Description',
      'isCompleted': true,
      'dueDate': DateTime.now().toIso8601String(),
      'createdOn': DateTime.now().toIso8601String(),
      'modifiedOn': DateTime.now().toIso8601String(),
      'estimatedTime': Duration(hours: 1).inMilliseconds,
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

    final fakeFirestore = FakeFirebaseFirestore(); // Create an instance of FakeFirebaseFirestore
    final docReference = fakeFirestore.collection('tasks').doc('1');
    await docReference.set(taskModelJson);

    final mockDocumentSnapshot = await docReference.get();
    // Act
    final taskModel = TaskModel.fromSnapshot(mockDocumentSnapshot);

    // Assert
    expect(taskModel.title, 'Test Task');
    expect(taskModel.description, 'Task Description');
    expect(taskModel.isCompleted, true);
    expect(taskModel.dueDate, isA<DateTime>());
    expect(taskModel.createdOn, isA<DateTime>());
    expect(taskModel.modifiedOn, isA<DateTime>());
    expect(taskModel.estimatedTime, isA<DateTime>());
    expect(taskModel.assignedUserUids, ['user1', 'user2']);
    expect(taskModel.completedByUserUids, ['user3', 'user4']);
    expect(taskModel.notes, ['Note 1', 'Note 2']);
    expect(taskModel.comments, ['Comment 1', 'Comment 2']);
    expect(taskModel.score, 10);
    expect(taskModel.category, TaskCategory.shopping);
    expect(taskModel.reccuring, TaskReccuring.weekly);
    expect(taskModel.priority, TaskPriority.high);
    expect(taskModel.reminders, TaskReminders.daily);
  });

  test('Should convert TaskModel to valid Firestore document', () async {
    // Arrange
    final taskModel = TaskModel(
      id: '1',
      title: 'Test Task',
      description: 'Task Description',
      isCompleted: true,
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
    final document = taskModel.toDocument();

    // Assert
    expect(document['id'], '1');
    expect(document['title'], 'Test Task');
    expect(document['description'], 'Task Description');
    expect(document['isCompleted'], true);
    expect(document['dueDate'], isA<String>());
    expect(document['createdOn'], isA<String>());
    expect(document['modifiedOn'], isA<String>());
    expect(document['estimatedTime'], isA<String>());
    expect(document['assignedUserUids'], ['user1', 'user2']);
    expect(document['completedByUserUids'], ['user3', 'user4']);
    expect(document['notes'], ['Note 1', 'Note 2']);
    expect(document['comments'], ['Comment 1', 'Comment 2']);
    expect(document['score'], 10);
    expect(document['category'], TaskCategory.shopping.index);
    expect(document['reccuring'], TaskReccuring.weekly.index);
    expect(document['priority'], TaskPriority.high.index);
    expect(document['reminders'], TaskReminders.daily.index);
  });

  test('Should convert TaskModel to valid Task entity', () {
    // Arrange
    final taskModel = TaskModel(
      id: '1',
      title: 'Test Task',
      description: 'Task Description',
      isCompleted: true,
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
    final taskEntity = Task.fromModel(taskModel);

    // Assert
    expect(taskEntity.title, Title.create('Test Task'));
    expect(taskEntity.description, Description.Description.create('Task Description'));
    expect(taskEntity.isCompleted, true);
    expect(taskEntity.dueDate, isA<DateTime>());
    expect(taskEntity.createdOn, isA<DateTime>());
    expect(taskEntity.modifiedOn, isA<DateTime>());
    expect(taskEntity.estimatedTime, isA<DateTime>());
    expect(taskEntity.assignedUserUids, ['user1', 'user2']);
    expect(taskEntity.completedByUserUids, ['user3', 'user4']);
    expect(taskEntity.notes, ['Note 1', 'Note 2']);
    expect(taskEntity.comments, ['Comment 1', 'Comment 2']);
    expect(taskEntity.score, Score.create(10));
    expect(taskEntity.category, TaskCategory.shopping);
    expect(taskEntity.reccuring, TaskReccuring.weekly);
    expect(taskEntity.priority, TaskPriority.high);
    expect(taskEntity.reminders, TaskReminders.daily);
  });
}
