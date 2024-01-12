import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/domain/entities/update_task_params.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task_state.dart';
import 'package:hometasks/src/features/tasks/presentation/filters/task_view_filter.dart';
void main() {
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

  group('TasksViewState', () {
    TasksViewState createSubject({
      TasksViewStatus status = TasksViewStatus.initial,
      List<Task>? tasks,
      TaskViewFilter filter = TaskViewFilter.all,
      Task? lastDeletedTask,
      String? errorMessage
    }) {
      return TasksViewState(
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