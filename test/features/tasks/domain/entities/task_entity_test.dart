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
  group('Task Entity Tests', () {
    test('Should create a valid Task entity from TaskModel', () {
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
      expect(taskEntity.estimatedTime, isA<Duration>());
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

    test('Should create a valid TaskModel from Task entity', () {
      // Arrange
      final taskEntity = Task(
        id: '1',
        title: Title.create('Test Task'),
        description: Description.Description.create('Task Description'),
        isCompleted: true,
        dueDate: DateTime.now(),
        createdOn: DateTime.now(),
        modifiedOn: DateTime.now(),
        estimatedTime: Duration(hours: 1),
        assignedUserUids: ['user1', 'user2'],
        completedByUserUids: ['user3', 'user4'],
        notes: ['Note 1', 'Note 2'],
        comments: ['Comment 1', 'Comment 2'],
        score: Score.create(10),
        category: TaskCategory.shopping,
        reccuring: TaskReccuring.weekly,
        priority: TaskPriority.high,
        reminders: TaskReminders.daily,
      );

      // Act
      final taskModel = taskEntity.toModel();

      // Assert
      expect(taskModel.title, 'Test Task');
      expect(taskModel.description, 'Task Description');
      expect(taskModel.isCompleted, true);
      expect(taskModel.dueDate, isA<DateTime>());
      expect(taskModel.createdOn, isA<DateTime>());
      expect(taskModel.modifiedOn, isA<DateTime>());
      expect(taskModel.estimatedTime, isA<Duration>());
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
  });
  group('Task Entity Functions Tests', () {
    test('Should create a Task entity from map using createTaskFromMap', () {
      // Arrange
      final Map<String, dynamic> taskMap = {
        'title': 'Test Task',
        'description': 'Task Description',
        'isCompleted': true,
        'dueDate': DateTime.now(),
        'createdOn': DateTime.now(),
        'modifiedOn': DateTime.now(),
        'estimatedTime': Duration(hours: 1),
        'assignedUserUids': ['user1', 'user2'],
        'completedByUserUids': ['user3', 'user4'],
        'notes': ['Note 1', 'Note 2'],
        'comments': ['Comment 1', 'Comment 2'],
        'score': 10,
        'category': TaskCategory.shopping,
        'reccuring': TaskReccuring.weekly,
        'priority': TaskPriority.high,
        'reminders': TaskReminders.daily,
      };

      // Act
      final taskEntity = Task.createTaskFromMap(taskMap);

      // Assert
      expect(taskEntity.title, Title.create('Test Task'));
      expect(taskEntity.description, Description.Description.create('Task Description'));
      expect(taskEntity.isCompleted, true);
      expect(taskEntity.dueDate, isA<DateTime>());
      expect(taskEntity.createdOn, isA<DateTime>());
      expect(taskEntity.modifiedOn, isA<DateTime>());
      expect(taskEntity.estimatedTime, isA<Duration>());
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

    test('Should copy a Task entity with updated fields using copyWithFromMap', () {
      // Arrange
      final taskEntity = Task(
        id: '1',
        title: Title.create('Test Task'),
        description: Description.Description.create('Task Description'),
        isCompleted: true,
        dueDate: DateTime.now(),
        createdOn: DateTime.now(),
        modifiedOn: DateTime.now(),
        estimatedTime: Duration(hours: 1),
        assignedUserUids: ['user1', 'user2'],
        completedByUserUids: ['user3', 'user4'],
        notes: ['Note 1', 'Note 2'],
        comments: ['Comment 1', 'Comment 2'],
        score: Score.create(10),
        category: TaskCategory.shopping,
        reccuring: TaskReccuring.weekly,
        priority: TaskPriority.high,
        reminders: TaskReminders.daily,
      );

      final Map<String, dynamic> updatedFields = {
        'title': 'Updated Task',
        'description': 'Updated Description',
        'isCompleted': false,
        'dueDate': DateTime.now().add(Duration(days: 1)),
        'modifiedOn': DateTime.now().add(Duration(days: 1)),
        'assignedUserUids': ['user5', 'user6'],
        'completedByUserUids': ['user7', 'user8'],
        'notes': ['Updated Note'],
        'comments': ['Updated Comment'],
        'score': 20,
      };

      // Act
      final updatedTaskEntity = taskEntity.copyWithFromMap(updatedFields);

      // Assert
      expect(updatedTaskEntity.title, Title.create('Updated Task'));
      expect(updatedTaskEntity.description, Description.Description.create('Updated Description'));
      expect(updatedTaskEntity.isCompleted, false);
      expect(updatedTaskEntity.dueDate, isA<DateTime>());
      expect(updatedTaskEntity.modifiedOn, isA<DateTime>());
      expect(updatedTaskEntity.assignedUserUids, ['user5', 'user6']);
      expect(updatedTaskEntity.completedByUserUids, ['user7', 'user8']);
      expect(updatedTaskEntity.notes, ['Updated Note']);
      expect(updatedTaskEntity.comments, ['Updated Comment']);
      expect(updatedTaskEntity.score, Score.create(20));
      // Other fields remain unchanged
      expect(updatedTaskEntity.category, TaskCategory.shopping);
      expect(updatedTaskEntity.reccuring, TaskReccuring.weekly);
      expect(updatedTaskEntity.priority, TaskPriority.high);
      expect(updatedTaskEntity.reminders, TaskReminders.daily);
    });
  });
}
