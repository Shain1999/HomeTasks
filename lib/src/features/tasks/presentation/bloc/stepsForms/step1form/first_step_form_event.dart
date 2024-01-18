import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';

class UpdateTaskCategoryEvent extends MainFormEvent {
  final TaskCategory newCategory;

  UpdateTaskCategoryEvent(this.newCategory);
}

class UpdateTaskPriorityEvent extends MainFormEvent {
  final TaskPriority newPriority;

  UpdateTaskPriorityEvent(this.newPriority);
}