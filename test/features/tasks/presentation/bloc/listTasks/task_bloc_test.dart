import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/core/response/response.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/update_task_params.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/tasks_use_cases.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/listTasks/task_bloc.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/listTasks/task_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/listTasks/task_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helper.mocks.dart';



void main() {
  const GetTaskParams params = GetTaskParams();
   List<Task> testTaskList = [
    Task(
        title: 'task1',
        priority: TaskPriority.low,
        reminders: TaskReminders.weekly,
        category: TaskCategory.cleaning,
        reccuring: TaskReccuring.weekly),
    Task(
        title: 'task2',
        priority: TaskPriority.medium,
        reminders: TaskReminders.weekly,
        category: TaskCategory.shopping,
        reccuring: TaskReccuring.daily),
    Task(
        title: 'task3',
        priority: TaskPriority.medium,
        reminders: TaskReminders.daily,
        category: TaskCategory.shopping,
        reccuring: TaskReccuring.mountly),
  ];
   Task testTask = Task(
      title: 'task3',
      priority: TaskPriority.medium,
      reminders: TaskReminders.daily,
      category: TaskCategory.shopping,
      reccuring: TaskReccuring.mountly);

  group('TaskViewBloc', () {
    late TaskListBloc taskViewBloc;
    late MockGetTasksUseCase mockGetTasksUseCase;
    late MockUpdateTaskUseCase mockUpdateTaskUseCase;
    late MockAddTaskUseCase mockAddTaskUseCase;
    late MockDeleteTaskUseCase mockDeleteTaskUseCase;

    setUp(() {
      mockGetTasksUseCase = MockGetTasksUseCase();
      mockAddTaskUseCase = MockAddTaskUseCase();
      mockUpdateTaskUseCase = MockUpdateTaskUseCase();
      mockDeleteTaskUseCase = MockDeleteTaskUseCase();
      taskViewBloc = TaskListBloc(
        taskUseCases: TaskUseCases(
          getTasks: mockGetTasksUseCase,
          addTask: mockAddTaskUseCase,
          updateTask: mockUpdateTaskUseCase,
          deleteTask: mockDeleteTaskUseCase,
          getTaskById: MockGetTaskByIdUseCase(),
        ),
      );
    });
    tearDown(() {
      taskViewBloc.close();
    });

    group('constructor', () {
      test('has correct initial state', () {
        expect(
          taskViewBloc.state,
          equals(const TasksViewState()),
        );
      });
    });

    group('onGetTasks', () {
      blocTest<TaskListBloc, TasksViewState>(
        'emits stream connection successfull when OnGetTasks is added',
        build: () => taskViewBloc,
        act: (bloc) {
          // Stub the handle method to return a Stream<List<Task>>
          when(mockGetTasksUseCase.handle(any)).thenAnswer(
                  (_) => Stream.value(testTaskList));
          // Trigger the OnGetTasks event
          bloc.add(const OnGetTasks());
        },
        verify: (_) {
          // Verify that getTasks use case is called once
          verify(mockGetTasksUseCase.handle(params)).called(1);
        },

      );
    });

    group('onTaskDelete', () {
      blocTest<TaskListBloc, TasksViewState>(
        'emits TaskDeleted and success status when OnDeleteTask is added',
        build: () => taskViewBloc,
        act: (bloc) async {
          // Stub the deleteTask use case to return a success Result
          when(mockDeleteTaskUseCase.handle('1'))
              .thenAnswer((_) async => Response.ok());

          // Trigger the OnDeleteTask event
          bloc.add(const OnDeleteTask('1'));

          // Wait for the stream to emit values
          await expectLater(
            bloc.stream,
            emitsInOrder([
              // Loading state
              isA<TasksViewState>().having(
                    (state) => state.status,
                'status',
                TasksViewStatus.loading,
              ),
              // TaskDeleted state
              isA<TasksViewState>().having(
                    (state) => state.status,
                'status',
                TasksViewStatus.success,
              ),
            ]),
          );
        },
        verify: (_) {
          // Verify that addTask use case is called once with the specific parameters
          verify(mockDeleteTaskUseCase.handle('1')).called(1);
        },
      );
    });
    blocTest<TaskListBloc, TasksViewState>(
      'emits TaskDeleted and failed status when OnDeleteTask is failed',
      build: () => taskViewBloc,
      act: (bloc) async {
        // Stub the deleteTask use case to return a success Result
        when(mockDeleteTaskUseCase.handle('1'))
            .thenAnswer((_) async => Response.internalError());

        // Trigger the OnDeleteTask event
        bloc.add(const OnDeleteTask('1'));

        // Wait for the stream to emit values
        await expectLater(
          bloc.stream,
          emitsInOrder([
            // Loading state
            isA<TasksViewState>().having(
                  (state) => state.status,
              'status',
              TasksViewStatus.loading,
            ),
            // TaskDeleted state
            isA<TasksViewState>().having(
                  (state) => state.status,
              'status',
              TasksViewStatus.failure,
            ),
          ]),
        );
      },
      verify: (_) {
        // Verify that addTask use case is called once with the specific parameters
        verify(mockDeleteTaskUseCase.handle('1')).called(1);
      },
    );
  });
}
