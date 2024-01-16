import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/score/score.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart' as Description;
import 'package:hometasks/src/features/tasks/presentation/bloc/listTasks/task_list_state.dart';
import 'package:hometasks/src/features/tasks/presentation/filters/task_view_filter.dart';
void main() {
  const GetTaskParams params = GetTaskParams();
  List<Task> testTaskList =[
    Task(
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
    ),
    Task(
      title: Title.create('Test Task 2' ),
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
    ),
    Task(
      title: Title.create('Test Task 3'),
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
    ),
  ];
  final testTask = Task(
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

  group('TasksViewState', () {
    TasksListState createSubject({
      TasksViewStatus status = TasksViewStatus.initial,
      List<Task>? tasks,
      TaskViewFilter filter = TaskViewFilter.all,
      Task? lastDeletedTask,
      String? errorMessage
    }) {
      return TasksListState(
          status: status,
          tasks: tasks ?? testTaskList,
          filter: filter,
          lastDeletedTask: lastDeletedTask,
          errorMessage: errorMessage
      );
    }
    test('supports value equality', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test('props are correct', () {
      expect(
        createSubject(
            status: TasksViewStatus.initial,
            tasks: testTaskList,
            filter: TaskViewFilter.all,
            lastDeletedTask: null,
            errorMessage: null
        ).props,
        equals(<Object?>[
          TasksViewStatus.initial, // status
          testTaskList, // tasks
          TaskViewFilter.all, // filter
          null, // lastDeletedTask,
          null
        ]),
      );
    });

    test('filtered tasks returns tasks filtered by filter', () {
      expect(
        createSubject(
          tasks: testTaskList,
          filter: TaskViewFilter.completedOnly,
        ).filteredTodos,
        equals(testTaskList.where((task) => task.isCompleted).toList()),
      );
    });
    group('copyWith', () {
      test('returns the same object if not arguments are provided', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('retains the old value for every parameter if null is provided', () {
        expect(
          createSubject().copyWith(
              status: null,
              tasks: null,
              filter: null,
              lastDeletedTask: null,
              errorMessage: null
          ),
          equals(createSubject()),
        );
      });
      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            status: () => TasksViewStatus.success,
            tasks: () => [],
            filter: () => TaskViewFilter.completedOnly,
            lastDeletedTask: () => testTask,
            errorMessage:  'error'
          ),
          equals(
            createSubject(
              status: TasksViewStatus.success,
              tasks: [],
              filter: TaskViewFilter.completedOnly,
              lastDeletedTask: testTask,
                errorMessage:  'error'
            ),
          ),
        );
      });

      test('can copyWith null lastDeletedTodo', () {
        expect(
          createSubject(lastDeletedTask: testTask).copyWith(
            lastDeletedTask: () => null,
          ),
          equals(createSubject(lastDeletedTask: null)),
        );
      });

    });
  });
}