import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/core/errors/task/task_error.dart';
import 'package:hometasks/src/core/response/response.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/get_tasks_use_case.dart';
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
    Task( title: 'task1', priority: TaskPriority.low, reminders: TaskReminders.weekly, category: TaskCategory.cleaning, reccuring: TaskReccuring.weekly),
    Task( title: 'task2', priority: TaskPriority.medium, reminders: TaskReminders.weekly, category: TaskCategory.shopping, reccuring: TaskReccuring.daily),
    Task( title: 'task3', priority: TaskPriority.medium, reminders: TaskReminders.daily, category: TaskCategory.shopping, reccuring: TaskReccuring.mountly),
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