import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/core/response/response.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late AddTaskUseCase addTaskUseCase;
  late MockDomainFirebaseTaskRepository mockDomainFirebaseTaskRepository;

  setUp(() {
    mockDomainFirebaseTaskRepository = MockDomainFirebaseTaskRepository();
    addTaskUseCase = AddTaskUseCase(repository: mockDomainFirebaseTaskRepository);
  });

   Task testTask = Task(
    id: '1',
    title: 'Sample Task',
    description: 'This is a sample task for testing.',
    isCompleted: false,
    dueDate: DateTime.now().add(Duration(days: 7)),
    createdOn: DateTime.now(),
    modifiedOn: DateTime.now(),
    estimatedTime: DateTime.now().add(Duration(hours: 2)),
    assignedUserUids: ['user1', 'user2'],
    completedByUserUids: ['user1'],
    notes: ['Note 1', 'Note 2'],
    comments: ['Comment 1', 'Comment 2'],
    score: 5,
    priority: TaskPriority.medium,
    reminders: TaskReminders.daily,
    category: TaskCategory.cleaning,
    reccuring: TaskReccuring.weekly,
  );

  test('should add task using the repository', () async {
    // arrange
    when(mockDomainFirebaseTaskRepository.addTask(testTask))
        .thenAnswer((_) async => Result.success());

    // act
    final result = await addTaskUseCase.handle(testTask);

    // assert
    expect(result, Response<Task>.ok(message: "Task added successfully"));
  });

  test('should handle error when adding task fails', () async {
    // arrange
    when(mockDomainFirebaseTaskRepository.addTask(testTask))
        .thenAnswer((_) async => Result.failure(internalCode: "addTaskFailure"));

    // act
    final result = await addTaskUseCase.handle(testTask);

    // assert
    expect(result, Response<Task>.internalError(
        message: "Failed to add task", internalCode: "addTaskFailure"));
  });
}
