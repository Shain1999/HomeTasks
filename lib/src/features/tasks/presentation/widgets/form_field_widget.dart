
// Widget example for the product name form field
import 'package:flutter/material.dart';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';

Widget stringFormField<String, ReturnType>({required FormFieldController<String, ReturnType>? formField}) {
  return StreamBuilder<FormFieldModel<ReturnType>>(
    stream: formField?.valueStream,
    builder: (context, snapshot) {
      return TextField(
        decoration: InputDecoration(
          labelText: formField?.label,
          errorText: snapshot.hasError ? snapshot.error.toString() : null,
        ),
        onChanged:(value)=> formField?.changeValue(value as String?),

      );
    },
  );
}
Widget intFormField<String, ReturnType>({required FormFieldController<int, ReturnType>? formField}) {
  return StreamBuilder<FormFieldModel<ReturnType>>(
    stream: formField?.valueStream,
    builder: (context, snapshot) {
      return TextField(decoration: InputDecoration(
          labelText: formField?.label,
          errorText: snapshot.hasError ? snapshot.error.toString() : null,
        ),
        onChanged:(value)=> formField?.changeValue(int.tryParse(value)),

      );
    },
  );
}
Widget dropDownTaskCategoryFormField({
  required TaskCategory? taskCategory,
  required Function(TaskCategory?) onCategoryChanged,
}) {
  return DropdownButtonFormField<TaskCategory>(
    value: taskCategory ?? TaskCategory.none,
    items: TaskCategory.values.map((value) {
      return DropdownMenuItem<TaskCategory>(
        value: value,
        child: Text(value.toString().split('.').last),
      );
    }).toList(),
    onChanged: (value) => onCategoryChanged(value),
    decoration: InputDecoration(
      labelText: "category",
    ),
  );
}

Widget dropDownTaskPriorityFormField({
  required TaskPriority? taskPriority,
  required Function(TaskPriority?) onPriorityChanged,
}) {
  return DropdownButtonFormField<TaskPriority>(
    value: taskPriority ?? TaskPriority.none,
    items: TaskPriority.values.map((value) {
      return DropdownMenuItem<TaskPriority>(
        value: value,
        child: Text(value.toString().split('.').last),
      );
    }).toList(),
    onChanged: (value) => onPriorityChanged(value),
    decoration: InputDecoration(
      labelText: "priority",
    ),
  );
}
Widget dropDownTaskRemindersFormField({
  required TaskReminders? taskReminders,
  required Function(TaskReminders?) onRemindersChanged,
}) {
  return DropdownButtonFormField<TaskReminders>(
    value: taskReminders ?? TaskReminders.none,
    items: TaskReminders.values.map((value) {
      return DropdownMenuItem<TaskReminders>(
        value: value,
        child: Text(value.toString().split('.').last),
      );
    }).toList(),
    onChanged: (value) => onRemindersChanged(value),
    decoration: InputDecoration(
      labelText: "reminders",
    ),
  );
}
Widget dropDownTaskReccuringFormField({
  required TaskReccuring? taskReccuring,
  required Function(TaskReccuring?) onReccuringChanged,
}) {
  return DropdownButtonFormField<TaskReccuring>(
    value: taskReccuring ?? TaskReccuring.none,
    items: TaskReccuring.values.map((value) {
      return DropdownMenuItem<TaskReccuring>(
        value: value,
        child: Text(value.toString().split('.').last),
      );
    }).toList(),
    onChanged: (value) => onReccuringChanged(value),
    decoration: InputDecoration(
      labelText: "reccuring",
    ),
  );
}


