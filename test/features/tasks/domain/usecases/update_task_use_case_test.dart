import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/core/response/response.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/domain/entities/update_task_params.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/update_task_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/score/score.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart' as Description;

import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late UpdateTaskUseCase updateTaskUseCase;
  late MockDomainFirebaseTaskRepository mockDomainFirebaseTaskRepository;

  setUp(() {
    mockDomainFirebaseTaskRepository = MockDomainFirebaseTaskRepository();
    updateTaskUseCase = UpdateTaskUseCase(repository: mockDomainFirebaseTaskRepository);
  });

  const String testTaskId = '158935489';
  final testTask = Task(
    id: '1',
    title: Title.create('Test Task'),
    description: Description.Description.create('Task Description'),
    isCompleted: true,
    dueDate: DateTime.now().add(Duration(days: 7)),
    createdOn: DateTime.now(),
    modifiedOn: DateTime.now(),
    estimatedTime: DateTime.now().add(Duration(hours: 2)),
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
  const Map<String, dynamic> updatedFields = {'priority': 'high', 'category': 'shopping'};

  test('should update task in the repository', () async {
    // arrange
    final updateParams = UpdateTaskParams(taskId: testTaskId, updatedFields: updatedFields);

    when(mockDomainFirebaseTaskRepository.updateTask(updateParams))
        .thenAnswer((_) async => Result.success());

    // act
    final result = await updateTaskUseCase.handle(updateParams);

    // assert
    expect(result, Response.ok(message: "Task updated successfully"));
  });

  test('should handle error when updating task fails', () async {
    // arrange
    final updateParams = UpdateTaskParams(taskId: testTaskId, updatedFields: updatedFields);

    when(mockDomainFirebaseTaskRepository.updateTask(updateParams))
        .thenAnswer((_) async => Result.failure(internalCode: "updateTaskFailure"));

    // act
    final result = await updateTaskUseCase.handle(updateParams);

    // assert
    expect(result, Response.internalError(
      message: "Failed to update task",
      internalCode: "updateTaskFailure",
    ));
  });
}
