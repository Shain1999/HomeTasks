import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/data/models/task_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:uuid/uuid.dart';

class Task extends Equatable {
  final String id; //id of the task
  final String title; //title
  final String? description; // description
  final bool isCompleted; // if the task is completed
  final DateTime? dueDate; // when the task is due
  final DateTime? createdOn; //time created
  final DateTime? estimatedTime; // how much time it would take
  final DateTime? modifiedOn; // last modified
  final TaskCategory category; // the category of the task
  final TaskReccuring reccuring; // the reaccurence of a specific class (enum)
  final TaskPriority priority; // the prioriy of the task (enum)
  final TaskReminders reminders; // the reminder alert frequency
  final List<String>?
  assignedUserUids; // all the users id assigned to this task
  final List<String>?
  completedByUserUids; // all the users that completed the task
  final List<String>? notes; // notes for complting the task
  final List<String>? comments; // comments on the task
  final int? score; // the score of the task

   Task(
      { String? id,
        required this.title,
        this.description,
        this.completedByUserUids,
        this.isCompleted = false,
        this.dueDate,
        this.createdOn,
        this.modifiedOn,
        this.estimatedTime,
        this.assignedUserUids,
        required this.priority,
        required this.reminders,
        this.notes,
        this.comments,
        this.score,
        required this.category,
        required this.reccuring}):id = id ?? _generateUuid();

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    isCompleted,
    dueDate,
    createdOn,
    modifiedOn,
    priority,
    estimatedTime,
    assignedUserUids,
    category,
    notes,
    reccuring,
    completedByUserUids,
    reminders,
    score,
    comments
  ];
  static  Task empty = Task(
    title: '',
    isCompleted: false,
    priority: TaskPriority.none,
    reminders: TaskReminders.none,
    category: TaskCategory.none,
    reccuring: TaskReccuring.none,
  );
  factory Task.initial() {
    return Task(
      title: '', // Provide appropriate default value
      isCompleted: false,
      priority: TaskPriority.none,
      reminders: TaskReminders.none,
      category: TaskCategory.none,
      reccuring: TaskReccuring.none,
    );
  }
  // An entity can be an object with methods, or it can be a set of
  // data structures and functions.
  bool get isEmpty => this == Task.empty;
  TaskModel toModel() {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      dueDate: dueDate,
      createdOn: createdOn,
      modifiedOn: modifiedOn,
      estimatedTime: estimatedTime,
      assignedUserUids: assignedUserUids,
      priority: priority,
      reminders: reminders,
      notes: notes,
      comments: comments,
      score: score,
      category: category,
      reccuring: reccuring,
      completedByUserUids: completedByUserUids,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'dueDate': dueDate?.toIso8601String(),
      'createdOn': createdOn?.toIso8601String(),
      'modifiedOn': modifiedOn?.toIso8601String(),
      'estimatedTime': estimatedTime?.toIso8601String(),
      'assignedUserUids': assignedUserUids,
      'priority': priority.toString(), // Assuming TaskPriority is an enum
      'reminders': reminders.toString(), // Assuming TaskReminders is an enum
      'notes': notes,
      'comments': comments,
      'score': score,
      'category': category.toString(), // Assuming TaskCategory is an enum
      'reccuring': reccuring.toString(), // Assuming TaskReccuring is an enum
      'completedByUserUids': completedByUserUids,
    };
  }
  factory Task.createTaskFromMap(Map<String, dynamic> updatedFields, Task task) {
    return Task(
      title: updatedFields['title'] ?? task.title,
      description: updatedFields['description'] ?? task.description,
      isCompleted: updatedFields['isCompleted'] ?? task.isCompleted,
      dueDate: updatedFields['dueDate'] ?? task.dueDate,
      createdOn: updatedFields['createdOn'] ?? task.createdOn,
      modifiedOn: updatedFields['modifiedOn'] ?? task.modifiedOn,
      estimatedTime: updatedFields['estimatedTime'] ?? task.estimatedTime,
      assignedUserUids: updatedFields['assignedUserUids'] ?? task.assignedUserUids,
      priority: updatedFields['priority'] ?? task.priority,
      reminders: updatedFields['reminders'] ?? task.reminders,
      notes: updatedFields['notes'] ?? task.notes,
      comments: updatedFields['comments'] ?? task.comments,
      score: updatedFields['score'] ?? task.score,
      category: updatedFields['category'] ?? task.category,
      reccuring: updatedFields['reccuring'] ?? task.reccuring,
      completedByUserUids: updatedFields['completedByUserUids'] ?? task.completedByUserUids,
    );
  }

  static String _generateUuid() {
    return Uuid().v4();
  }

}
