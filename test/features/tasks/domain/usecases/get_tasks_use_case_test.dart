import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/core/errors/task/task_error.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart' as Description;

import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/get_tasks_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/score/score.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main(){
   late GetTasksUseCase getTasksUseCase;
   late MockDomainFirebaseTaskRepository mockDomainFirebaseTaskRepository;
  setUp(() {
    mockDomainFirebaseTaskRepository=MockDomainFirebaseTaskRepository();
    getTasksUseCase=GetTasksUseCase(repository: mockDomainFirebaseTaskRepository);
  });

  List<Task> testTaskList =[
    Task(
      id: '1',
      title: Title.create('Test Task'),
      description: Description.Description.create('Task Description'),
      isCompleted: true,
      dueDate: DateTime.now().add(Duration(days: 7)),
      createdOn: DateTime.now(),
      modifiedOn: DateTime.now(),
      estimatedTime: Duration(hours: 2),
      assignedUserUids: ['user1', 'user2'],
      completedByUserUids: ['user3', 'user4'],
      notes: ['Note 1', 'Note 2'],
      comments: ['Comment 1', 'Comment 2'],
      score: Score.create(10),
      category: TaskCategory.shopping,
      reccuring: TaskReccuring.weekly,
      priority: TaskPriority.high,
      reminders: TaskReminders.daily,
    ),
    Task(
      id: '12',
      title: Title.create('Test Task 2' ),
      description: Description.Description.create('Task Description'),
      isCompleted: true,
      dueDate: DateTime.now().add(Duration(days: 7)),
      createdOn: DateTime.now(),
      modifiedOn: DateTime.now(),
      estimatedTime:Duration(hours: 2),
      assignedUserUids: ['user1', 'user2'],
      completedByUserUids: ['user3', 'user4'],
      notes: ['Note 1', 'Note 2'],
      comments: ['Comment 1', 'Comment 2'],
      score: Score.create(10),
      category: TaskCategory.shopping,
      reccuring: TaskReccuring.weekly,
      priority: TaskPriority.high,
      reminders: TaskReminders.daily,
    ),
    Task(
      id: '13',
      title: Title.create('Test Task 3'),
      description: Description.Description.create('Task Description'),
      isCompleted: true,
      dueDate: DateTime.now().add(Duration(days: 7)),
      createdOn: DateTime.now(),
      modifiedOn: DateTime.now(),
      estimatedTime: Duration(hours: 2),
      assignedUserUids: ['user1', 'user2'],
      completedByUserUids: ['user3', 'user4'],
      notes: ['Note 1', 'Note 2'],
      comments: ['Comment 1', 'Comment 2'],
      score: Score.create(10),
      category: TaskCategory.shopping,
      reccuring: TaskReccuring.weekly,
      priority: TaskPriority.high,
      reminders: TaskReminders.daily,
    ),
  ];
  const testGetTaskParams = GetTaskParams();
  test('should get tasks from the repository', () async {
    // arrange
    final StreamController<List<Task>> streamController = StreamController();
    when(mockDomainFirebaseTaskRepository.getTasksStream(testGetTaskParams)).thenAnswer((_) => streamController.stream);
    //act
    final Future<List<Task>> resultFuture = getTasksUseCase.handle(testGetTaskParams).first;


    // Emit data to the stream
    streamController.add(testTaskList);

    // Wait for the result
    final List<Task> result = await resultFuture;

    // Assert
    expect(result,  testTaskList);

    // Close the stream controller
    streamController.close();
  });
   test('should handle error when getting tasks fails', () async {
     // Arrange
     final StreamController<List<Task>> streamController = StreamController();
     when(mockDomainFirebaseTaskRepository.getTasksStream(testGetTaskParams)).thenAnswer((_) => streamController.stream);
     //act
     final Future<List<Task>> resultFuture = getTasksUseCase.handle(testGetTaskParams).first;

     // Emit error to the stream
     streamController.add([]);

     // Assert
     expect(() async => await resultFuture,throwsA(isA<TaskError>()));

     // Close the stream controller
     streamController.close();
   });
}