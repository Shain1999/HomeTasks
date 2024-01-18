import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';

class UpdateDueDateEvent extends MainFormEvent {
  final DateTime newDate;

  const UpdateDueDateEvent(this.newDate);
}

class UpdateEstimatedTimeEvent extends MainFormEvent {
  final Duration newTimeRange;

  const UpdateEstimatedTimeEvent(this.newTimeRange);
}
class UpdateTaskReminderEvent extends MainFormEvent {
  final TaskReminders newReminder;

  const UpdateTaskReminderEvent(this.newReminder);
}

class UpdateTaskReccuringEvent extends MainFormEvent {
  final TaskReccuring newReccuring;

  const UpdateTaskReccuringEvent(this.newReccuring);
}