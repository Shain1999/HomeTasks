
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';

class UpdateTaskParams {
  final String taskId;
  final Map<String, dynamic> updatedFields;

  UpdateTaskParams({required this.taskId, required this.updatedFields});

  factory UpdateTaskParams.createUpdateTaskParams(Task task, Map<String, dynamic> newFields) {
    final Map<String, dynamic> originalJson = task.toJson();
    final Map<String, dynamic> updatedFields = {};

    for (var entry in newFields.entries) {
      final key = entry.key;
      final originalValue = originalJson[key];
      final newValue = entry.value;

      if (originalValue != newValue) {
        updatedFields[key] = newValue;
      }
    }

    return UpdateTaskParams(taskId: task.id, updatedFields: updatedFields);
  }
}