import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/core/response/response.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/get_task_by_id_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/score/score.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart' as Description;

import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTaskByIdUseCase getTaskByIdUseCase;
  late MockDomainFirebaseTaskRepository mockDomainFirebaseTaskRepository;

  setUp(() {
    mockDomainFirebaseTaskRepository = MockDomainFirebaseTaskRepository();
    getTaskByIdUseCase = GetTaskByIdUseCase(repository: mockDomainFirebaseTaskRepository);
  });

  const String testTaskId = '158935489';
  final testTask = Task(
    id: '158935489',
    title: Title.create('Test Task'),
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
  );


  test('should fetch task by id from the repository', () async {
    // arrange
    when(mockDomainFirebaseTaskRepository.getTaskById(testTaskId))
        .thenAnswer((_) async => Result.success(value: testTask));

    // act
    final result = await getTaskByIdUseCase.handle(testTaskId);

    // assert
    expect(result, Response<Task>.ok(
      value: testTask,
      message: "Task fetched successfully",
    ));
  });

  test('should handle error when fetching task by id fails', () async {
    // arrange
    when(mockDomainFirebaseTaskRepository.getTaskById(testTaskId))
        .thenAnswer((_) async => Result.failure(internalCode: "getTaskByIdFailure"));

    // act
    final result = await getTaskByIdUseCase.handle(testTaskId);

    // assert
    expect(result, Response<Task>.internalError(
      message: "Failed to fetch task",
      internalCode: "getTaskByIdFailure",
    ));
  });
}
