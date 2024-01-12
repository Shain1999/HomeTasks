import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/domain/entities/update_task_params.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task_event.dart';
import 'package:hometasks/src/features/tasks/presentation/filters/task_view_filter.dart';
import 'package:mockito/mockito.dart';

void main(){

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


  group('TaskViewEvent', () {

    group('OnGetTasks', () {
      test('supports value equality', () {
        expect(
          const OnGetTasks(params),
          equals(const OnGetTasks(params)),
        );
      });
      test('props are correct', () {
        expect(
          const OnGetTasks(params).props,
          equals(<Object?>[params]),
        );
      });
    });

    group('OnAddTask', () {
      test('supports value equality', () {
        expect(
          const OnAddTask(testTask),
          equals(const OnAddTask(testTask)),
        );
      });
      test('props are correct', () {
        expect(
          const OnAddTask(testTask).props,
          equals(<Object?>[testTask]),
        );
      });
    });
    group('OnUpdateTask', () {
      const Map<String, dynamic> updatedFields = {'priority': 'high', 'category': 'shopping'};
      final updateParams = UpdateTaskParams.createUpdateTaskParams(testTask, updatedFields);

      test('supports value equality', () {
        expect(
          OnUpdateTask(taskId: testTask.id,updatedFields: updatedFields,taskToUpdate: testTask),
          equals(OnUpdateTask(taskId: testTask.id,updatedFields: updatedFields,taskToUpdate: testTask)),
        );
      });
      test('props are correct', () {
        expect(
          OnUpdateTask(taskId: testTask.id,updatedFields: updatedFields,taskToUpdate: testTask).props,
          equals(<Object?>[testTask.id,updatedFields,testTask]),
        );
      });
    });
    group('OnDeleteTask', () {
      test('supports value equality', () {
        expect(
          OnDeleteTask(testTask.id),
          equals(OnDeleteTask(testTask.id)),
        );
      });
      test('props are correct', () {
        expect(
          OnDeleteTask(testTask.id).props,
          equals(<Object?>[testTask.id]),
        );
      });
    });
    group('OnTasksViewFilterChanged', () {
      test('supports value equality', () {
        expect(
          const OnTasksViewFilterChanged(TaskViewFilter.all),
          equals(const OnTasksViewFilterChanged(TaskViewFilter.all)),
        );
      });

      test('props are correct', () {
        expect(
          const OnTasksViewFilterChanged(TaskViewFilter.all).props,
          equals(<Object?>[
            TaskViewFilter.all, // filter
          ]),
        );
      });
    });

    //////////////////
  });
}