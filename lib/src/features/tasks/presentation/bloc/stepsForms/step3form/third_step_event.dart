import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';

class UpdateAssignedUserUidList extends MainFormEvent {
  final List<String> newList;

  const UpdateAssignedUserUidList(this.newList);
}

class UpdateNotesList extends MainFormEvent {
  final List<String> newList;

  const UpdateNotesList(this.newList);
}
class UpdateCommentsList extends MainFormEvent {
  final List<String> newList;

  const UpdateCommentsList(this.newList);
}
