import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/domain/validators/due_date_validator.dart';
import 'package:hometasks/src/features/tasks/domain/validators/regular_validator.dart';
import 'package:hometasks/src/features/tasks/domain/validators/title_validator.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';

class SecondStepFormState extends ChildStepFormState {
  SecondStepFormState({
    this.step = CurrentStep.step2,
    this.status = ChildStepFormStatus.initial,
    this.errorMessage,
    FormFieldController<DateTime, DateTime>? dueDateField,
    FormFieldController<DateTime, DateTime>? estimatedTimeField,
    FormFieldController<TaskReminders,TaskReminders>? reminderField,
    FormFieldController<TaskReccuring,TaskReccuring>? reccuringField
  })
    :dueDateField =dueDateField ?? FormFieldController<DateTime, DateTime>(
      validateFunction: validateDateTime,
    fieldName: 'dueDate'),
    estimatedTimeField =estimatedTimeField ?? FormFieldController<DateTime, DateTime>(
        validateFunction: validateDateTime,
    fieldName: 'estimatedTime'),
    reminderField =reminderField ?? FormFieldController<TaskReminders,TaskReminders>(
        validateFunction: validateGenericTypes,
    fieldName: 'reminders',labelName: 'reminder'),
    reccuringField =reccuringField ?? FormFieldController<TaskReccuring,TaskReccuring>(
        validateFunction: validateGenericTypes,
    fieldName: 'reccuring'),


        super();
  final CurrentStep step;
  final ChildStepFormStatus status;
  final FormFieldController<DateTime, DateTime>? dueDateField;
  final FormFieldController<DateTime, DateTime>? estimatedTimeField;
  final FormFieldController<TaskReminders,TaskReminders>? reminderField;
  final FormFieldController<TaskReccuring,TaskReccuring>? reccuringField;
  final String? errorMessage;

  @override
  SecondStepFormState copyWith({

    ChildStepFormStatus Function()? status,
    FormFieldController<DateTime, DateTime> Function()? dueDateField,
    FormFieldController<DateTime, DateTime>Function()? estimatedTimeField,
    FormFieldController<TaskReminders,TaskReminders>Function()? reminderField,
    FormFieldController<TaskReccuring,TaskReccuring>Function()? reccuringField,
    String? errorMessage
  }) {
    return SecondStepFormState(
        status: status != null ? status() : this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        dueDateField: dueDateField != null ? dueDateField() : this.dueDateField,
        estimatedTimeField: estimatedTimeField != null ? estimatedTimeField() : this.estimatedTimeField,
        reminderField: reminderField != null ? reminderField() : this.reminderField,
        reccuringField: reccuringField != null ? reccuringField() : this.reccuringField,
        step: this.step
    );
  }
  Map<String, dynamic> getCurrentValuesToMap() {
    return {
      'dueDate': dueDateField?.value,
      'estimatedTime': estimatedTimeField?.value,
      'reminders': reminderField?.value,
      'reccuring': reccuringField?.value,
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
