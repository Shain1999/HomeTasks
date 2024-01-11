import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';

enum TaskViewFilter { all, activeOnly, completedOnly }

extension TaskViewFilterX on TaskViewFilter {
  bool apply(Task task) {
    switch (this) {
      case TaskViewFilter.all:
        return true;
      case TaskViewFilter.activeOnly:
        return !task.isCompleted;
      case TaskViewFilter.completedOnly:
        return task.isCompleted;
    }
  }

  Iterable<Task> applyAll(Iterable<Task> todos) {
    return todos.where(apply);
  }
}