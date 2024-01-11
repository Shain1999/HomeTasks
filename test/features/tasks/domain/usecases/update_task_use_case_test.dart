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
  const Task testTask = Task(
    id: '158935489',
    title: 'Sample Task',
    priority: TaskPriority.medium,
    reminders: TaskReminders.weekly,
    category: TaskCategory.cleaning,
    reccuring: TaskReccuring.weekly,
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
