import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/domain/entities/update_task_params.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/listTasks/task_event.dart';
import 'package:hometasks/src/features/tasks/presentation/filters/task_view_filter.dart';
import 'package:mockito/mockito.dart';

void main(){

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


  group('TaskViewEvent', () {

    group('OnGetTasks', () {
      test('supports value equality', () {
        expect(
          const OnGetTasks(),
          equals(const OnGetTasks()),
        );
      });
      test('props are correct', () {
        expect(
          const OnGetTasks().props,
          equals(<Object?>[]),
        );
      });
    });

    group('OnAddTask', () {
      test('supports value equality', () {
        expect(
           OnAddTask(testTask),
          equals(OnAddTask(testTask)),
        );
      });
      test('props are correct', () {
        expect(
           OnAddTask(testTask).props,
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