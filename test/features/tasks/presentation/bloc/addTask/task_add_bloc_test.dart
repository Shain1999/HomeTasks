import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/core/response/response.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/addTask/task_add_bloc.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helper.mocks.dart';



void main() {

  final taskMap = {
    'title': 'Test Task',
    'description': 'Task Description',
    'isCompleted': true,
    'dueDate': DateTime.now(),
    'createdOn': DateTime.now(),
    'modifiedOn': DateTime.now(),
    'estimatedTime': DateTime.now(),
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
  Task testTask= Task.createTaskFromMap(taskMap);
  group('TaskAddBloc', () {
    late TaskAddBloc taskAddBloc;
    late MockAddTaskUseCase mockAddTaskUseCase;

    setUp(() {
      mockAddTaskUseCase = MockAddTaskUseCase();
      taskAddBloc = TaskAddBloc(addTaskUseCase: mockAddTaskUseCase);
    });

    tearDown(() {
      taskAddBloc.close();
    });

    group('constructor', () {
      test('has correct initial state', () {
        expect(
          taskAddBloc.state,
          equals(const TaskState()),
        );
      });
    });

    group('onAddTask', () {
      blocTest<TaskAddBloc, TaskState>(
        'emits OnFormSubmit successfully when OnFormSubmit is added',
        build: () => taskAddBloc,
        act: (bloc) {
          // Stub the handle method to return a successful Result
          when(mockAddTaskUseCase.handle(any)).thenAnswer(
                (_) async => Response<Task>.ok(),
          );

          // Trigger the OnFormSubmit event
          bloc.add(const OnFormSubmitEvent());
        },
        verify: (_) {
          // Verify that addTask use case is called once
          verify(mockAddTaskUseCase.handle(any)).called(1);
        },
      );
    });

    blocTest<TaskAddBloc, TaskState>(
      'emits OnFormSubmit and failed status when OnFormSubmit is failed',
      build: () => taskAddBloc,
      act: (bloc) async {
        // Stub the handle method to return an error Result
        when(mockAddTaskUseCase.handle(any)).thenAnswer(
              (_) async => Response.internalError(),
        );

        // Trigger the OnFormSubmit event
        bloc.add(const OnFormSubmitEvent());

        // Wait for the stream to emit values
        await expectLater(
          bloc.stream,
          emitsInOrder([
            // Loading state
            isA<TaskState>().having(
                  (state) => state.status,
              'status',
              TaskStatus.loading,
            ),
            // TaskDeleted state
            isA<TaskState>().having(
                  (state) => state.status,
              'status',
              TaskStatus.failure,
            ),
          ]),
        );
      },
      verify: (_) {
        // Verify that addTask use case is called once with the specific parameters
        verify(mockAddTaskUseCase.handle(any)).called(1);
      },
    );
  });
}
