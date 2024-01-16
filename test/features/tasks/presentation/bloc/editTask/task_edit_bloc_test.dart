import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/core/response/response.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/update_task_params.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/editTask/task_edit_bloc.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/editTask/task_edit_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helper.mocks.dart';



void main() {
  const Map<String, dynamic> updatedFields = {
    'priority': 'high',
    'category': 'shopping'
  };

  final taskMap = {
    'id': '1',
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
  final UpdateTaskParams updateTaskParams = UpdateTaskParams
      .createUpdateTaskParams(Task.createTaskFromMap(taskMap), updatedFields);
  Task testTask = Task.createTaskFromMap(taskMap);
  group('TaskEditBloc', () {
    late TaskEditBloc taskEditBloc;
    late MockUpdateTaskUseCase mockUpdateTaskUseCase;

    setUp(() {
      mockUpdateTaskUseCase = MockUpdateTaskUseCase();
      taskEditBloc = TaskEditBloc(updateTaskUseCase: mockUpdateTaskUseCase);
    });

    tearDown(() {
      taskEditBloc.close();
    });

    group('constructor', () {
      test('has correct initial state', () {
        expect(
          taskEditBloc.state,
          equals(const TaskState()),
        );
      });
    });
    group('onUpdateTask OnInitEdit', () {
      blocTest<TaskEditBloc, TaskState>(
        'emits OnInitEdit successfully when OnInitEdit is added',
        build: () => taskEditBloc,
        act: (bloc) {
          // Dispatch the OnInitEditEvent
          bloc.add(OnInitEditEvent(task: testTask));
          },
        expect: () => [
          // Loading state
          isA<TaskState>().having(
                (state) => state.task,
            'task',
            testTask,
          ),

        ],
      );
    });

    group('onUpdateTask Success', () {
      blocTest<TaskEditBloc, TaskState>(
        'emits OnFormSubmit successfully when OnFormSubmit is added',
        build: () => taskEditBloc,
        act: (bloc) {
          bloc.setTestTask(testTask);
          // Stub the handle method to return a successful Result
          when(mockUpdateTaskUseCase.handle(any)).thenAnswer(
                (_) async => Response<Task>.ok(),
          );

          // Trigger the OnFormSubmit event
          bloc.add(const OnFormSubmitEvent());
        },
        verify: (_) {
          // Verify that addTask use case is called once
          verify(mockUpdateTaskUseCase.handle(any)).called(1);
        },
      );
    });

    group('onUpdateTask Fail', () {
      blocTest<TaskEditBloc, TaskState>(
        'emits OnFormSubmit and failed status when OnFormSubmit is failed',
        build: () => taskEditBloc,
        act: (bloc) async {
          bloc.setTestTask(testTask);
          bloc.setTestUpdateFields(updatedFields);
          // Stub the handle method to return an error Result
          when(mockUpdateTaskUseCase.handle(any)).thenAnswer(
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
          verify(mockUpdateTaskUseCase.handle(any)).called(1);
        },
      );
    });
  });
}
