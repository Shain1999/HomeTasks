import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/core/response/response.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/delete_task_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late DeleteTaskUseCase deleteTaskUseCase;
  late MockDomainFirebaseTaskRepository mockDomainFirebaseTaskRepository;

  setUp(() {
    mockDomainFirebaseTaskRepository = MockDomainFirebaseTaskRepository();
    deleteTaskUseCase = DeleteTaskUseCase(repository: mockDomainFirebaseTaskRepository);
  });

  const String testTaskId = '158935489';

  test('should delete task from the repository', () async {
    // arrange
    when(mockDomainFirebaseTaskRepository.deleteTask(testTaskId))
        .thenAnswer((_) async => Result.success());

    // act
    final result = await deleteTaskUseCase.handle(testTaskId);

    // assert
    expect(result, Response.ok(message: "Task deleted successfully"));
  });

  test('should handle error when deleting task fails', () async {
    // arrange
    when(mockDomainFirebaseTaskRepository.deleteTask(testTaskId))
        .thenAnswer((_) async => Result.failure(internalCode: "deleteTaskFailure"));

    // act
    final result = await deleteTaskUseCase.handle(testTaskId);

    // assert
    expect(result, Response.internalError(
      message: "Failed to delete task",
      internalCode: "deleteTaskFailure",
    ));
  });
}
