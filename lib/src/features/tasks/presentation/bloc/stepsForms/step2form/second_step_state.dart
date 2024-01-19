import 'package:flutter/cupertino.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';

class SecondStepFormState extends ChildStepFormState {
  SecondStepFormState({
    this.step = CurrentStep.step2,
    this.status = ChildStepFormStatus.initial,
    this.errorMessage,
    DateTime? dueDateField,
    this.estimatedTimeField=const Duration(hours: 1),
    this.reminderField = TaskReminders.none,
    this.reccuringField = TaskReccuring.none
  })
      :dueDateField=dueDateField ?? DateTime.now().add(const Duration(hours: 1)),
        super();
  final CurrentStep step;
  final ChildStepFormStatus status;
  final DateTime dueDateField;
  final Duration estimatedTimeField;
  final TaskReminders reminderField;
  final TaskReccuring reccuringField;
  final String? errorMessage;

  @override
  SecondStepFormState copyWith({
    ChildStepFormStatus Function()? status,
    DateTime Function()? dueDateField,
    Duration Function()? estimatedTimeField,
    TaskReminders Function()? reminderField,
    TaskReccuring Function()? reccuringField,
    String? errorMessage,
  }) {
    return SecondStepFormState(
      status: status != null ? status() : this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      dueDateField: dueDateField != null ? dueDateField() : this.dueDateField,
      estimatedTimeField: estimatedTimeField != null
          ? estimatedTimeField()
          : this.estimatedTimeField,
      reminderField: reminderField != null ? reminderField() : this.reminderField,
      reccuringField: reccuringField != null ? reccuringField() : this.reccuringField,
      step: this.step,
    );
  }
  bool get isFormValid=>
      dueDateField!=null &&
          estimatedTimeField != null&&
          reminderField != TaskReminders.none &&
          reccuringField != TaskReccuring.none;

  Map<String, dynamic> getCurrentValuesToMap() {
    return {
      'dueDate': dueDateField,
      'estimatedTime': estimatedTimeField,
      'reminders': reminderField,
      'reccuring': reccuringField,
    };
  }


  @override
  List<Object?> get props =>
      [
        status,
        dueDateField,
        estimatedTimeField,
        reccuringField,
        reminderField,
        errorMessage
      ];
}
