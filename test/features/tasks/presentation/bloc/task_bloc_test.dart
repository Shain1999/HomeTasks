import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/core/response/response.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/tasks_use_cases.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task_state.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
//   late MockGetTasksUseCase mockGetTasksUseCase;
//   late MockAddTaskUseCase mockAddTaskUseCase;
//   late MockUpdateTaskUseCase mockUpdateTaskUseCase;
//   late MockDeleteTaskUseCase mockDeleteTaskUseCase;
//   late MockGetTaskByIdUseCase mockGetTaskByIdUseCase;
//   late TaskBloc taskBloc;
//   setUp(() {
//     mockGetTasksUseCase=MockGetTasksUseCase();
//     mockAddTaskUseCase=MockAddTaskUseCase();
//     mockUpdateTaskUseCase=MockUpdateTaskUseCase();
//     mockDeleteTaskUseCase=MockDeleteTaskUseCase();
//     mockGetTaskByIdUseCase=MockGetTaskByIdUseCase();
//     taskBloc = TaskBloc(mockGetTasksUseCase,mockAddTaskUseCase,mockUpdateTaskUseCase,mockDeleteTaskUseCase,mockGetTaskByIdUseCase);
//   });
//
//   test('initial state should be empty', () {
//     expect(taskBloc.state, TaskEmpty());
//   });
//   const GetTaskParams params = GetTaskParams();
//   const List<Task> testTaskList =[
//     Task(id: '158935489', title: 'task1', priority: TaskPriority.low, reminders: TaskReminders.weekly, category: TaskCategory.cleaning, reccuring: TaskReccuring.weekly),
//     Task(id: '158935terre32##489', title: 'task2', priority: TaskPriority.medium, reminders: TaskReminders.weekly, category: TaskCategory.shopping, reccuring: TaskReccuring.daily),
//     Task(id: '15re32##489', title: 'task3', priority: TaskPriority.medium, reminders: TaskReminders.daily, category: TaskCategory.shopping, reccuring: TaskReccuring.mountly),
//   ];
//   const Task testTask = Task(id: '15re32##489', title: 'task3', priority: TaskPriority.medium, reminders: TaskReminders.daily, category: TaskCategory.shopping, reccuring: TaskReccuring.mountly);
//
//   blocTest<TaskBloc, TaskState>(
//     'emits [TaskLoading, TasksListLoaded] when OnGetTasks event is added',
//     build: () {
//       when(mockGetTasksUseCase.handle(params)).thenAnswer((_) {
//         final StreamController<Response<List<Task>>> controller = StreamController();
//
//         // You can add more elements to the stream if needed
//         controller.add(Response.ok(value: testTaskList));
//
//         return controller.stream;
//       });
//
//       return taskBloc;
//     },
//     act: (bloc) {
//       bloc.add(OnGetTasks(params));
//     },
//     expect: () async* {
//       // Yield the initial state
//       yield TaskLoading();
//
//       // Delay to allow the stream to process
//       await Future.delayed(Duration.zero);
//
//       // Emit the TasksListLoaded state
//       yield TasksListLoaded(testTaskList);
//     },
//   );
//   blocTest<TaskBloc, TaskState>(
//     'emits [TaskLoading, TaskLoadFailure] when OnGetTasks event results in an error',
//     build: () {
//       when(mockGetTasksUseCase.handle(params)).thenAnswer(
//             (_) async => Response<List<Task>>.internalError(
//               message: "Failed to fetch tasks",
//               internalCode: "getTasksFailure",
//         ),
//       );
//       return taskBloc;
//     },
//     act: (bloc) {
//       bloc.add(OnGetTasks(params));
//     },
//     expect: () => [
//       TaskLoading(),
//       TasksListLoadFailure(
//         Response.internalError(
//           message: "Failed to fetch tasks",
//           internalCode: "getTasksFailure",
//         ),
//       ),
//     ],
//   );
//   blocTest<TaskBloc, TaskState>(
//     'emits [TaskLoading, TaskAdded] when OnAddTask event is added',
//     build: () {
//       when(mockAddTaskUseCase.handle(any)).thenAnswer(
//             (_) async => Response<Task>.ok(
//           value: testTask,
//           message: "Task added successfully",
//         ),
//       );
//       return taskBloc;
//     },
//     act: (bloc) {
//       bloc.add(OnAddTask(testTask));
//     },
//     expect: () => [
//       TaskLoading(),
//       TaskAdded(testTask),
//     ],
//   );
//   blocTest<TaskBloc, TaskState>(
//     'emits [TaskLoading, TaskUpdateFailure] when OnUpdateTask event results in an error',
//     build: () {
//       when(mockUpdateTaskUseCase.handle(any)).thenAnswer(
//             (_) async => Response.internalError(
//           message: "Failed to update task",
//           internalCode: "updateTaskFailure",
//         ),
//       );
//       return taskBloc;
//     },
//     act: (bloc) {
//       bloc.add(OnUpdateTask('1', {'title': 'Updated Task'},testTask));
//     },
//     expect: () => [
//       TaskLoading(),
//       TaskUpdateFailure(
//         Response.internalError(
//           message: "Failed to update task",
//           internalCode: "updateTaskFailure",
//         ),
//       ),
//     ],
//   );
//
//   blocTest<TaskBloc, TaskState>(
//     'emits [TaskLoading, TaskDeleted] when OnDeleteTask event is added',
//     build: () {
//       when(mockDeleteTaskUseCase.handle(any)).thenAnswer(
//             (_) async => Response.ok(message: "Task deleted successfully"),
//       );
//       return taskBloc;
//     },
//     act: (bloc) {
//       bloc.add(OnDeleteTask('1'));
//     },
//     expect: () => [
//       TaskLoading(),
//       TaskDeleted(),
//     ],
//   );
//   blocTest<TaskBloc, TaskState>(
//     'emits [TaskLoading, TaskLoadFailure] when OnGetTaskById event results in an error',
//     build: () {
//       when(mockGetTaskByIdUseCase.handle(any)).thenAnswer(
//             (_) async => Response.internalError(
//           message: "Failed to get task by ID",
//           internalCode: "getTaskByIdFailure",
//         ),
//       );
//       return taskBloc;
//     },
//     act: (bloc) {
//       bloc.add(OnGetTaskById('1'));
//     },
//     expect: () => [
//       TaskLoading(),
//       TaskLoadFailure(
//         Response.internalError(
//           message: "Failed to get task by ID",
//           internalCode: "getTaskByIdFailure",
//         ),
//       ),
//     ],
//   );
// }
  const GetTaskParams params = GetTaskParams();
  const List<Task> testTaskList = [
    Task(id: '158935489',
        title: 'task1',
        priority: TaskPriority.low,
        reminders: TaskReminders.weekly,
        category: TaskCategory.cleaning,
        reccuring: TaskReccuring.weekly),
    Task(id: '158935terre32##489',
        title: 'task2',
        priority: TaskPriority.medium,
        reminders: TaskReminders.weekly,
        category: TaskCategory.shopping,
        reccuring: TaskReccuring.daily),
    Task(id: '15re32##489',
        title: 'task3',
        priority: TaskPriority.medium,
        reminders: TaskReminders.daily,
        category: TaskCategory.shopping,
        reccuring: TaskReccuring.mountly),
  ];
  const Task testTask = Task(id: '15re32##489',
      title: 'task3',
      priority: TaskPriority.medium,
      reminders: TaskReminders.daily,
      category: TaskCategory.shopping,
      reccuring: TaskReccuring.mountly);

  group('TaskViewBloc', () {
    late MockTaskUseCases mockTaskUseCases;
    late MockDomainFirebaseTaskRepository repository;
    setUpAll(() {
      mockTaskUseCases = MockTaskUseCases();
      repository = MockDomainFirebaseTaskRepository();
    });
    TaskViewBloc buildBloc() {
      return TaskViewBloc(
          taskUseCases: mockTaskUseCases, taskRepository: repository);
    }
    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(const TasksViewState()),
        );
      });
    });

    group('onGetTasks', () {
      mockTaskUseCases = MockTaskUseCases();

      when(
        mockTaskUseCases.getTasks.handle(params),
      ).thenAnswer((_) =>Stream.value(testTaskList));

      blocTest<TaskViewBloc, TasksViewState>(
        'starts listening to repository getTodos stream',
        build: buildBloc,
        act: (bloc) => bloc.add(const OnGetTasks(params)),
        verify: (_) {
          verify(() => mockTaskUseCases.getTasks.handle(params)).called(1);
        },
      );
      ///////////////
    });
  });
}
