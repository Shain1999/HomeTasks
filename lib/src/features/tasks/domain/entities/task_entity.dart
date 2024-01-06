import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';

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

  const Task(
      {required this.id,
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
        required this.reccuring});

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
  static const Task empty = Task(
    id: '',
    title: '',
    isCompleted: false,
    priority: TaskPriority.none, // Provide appropriate default value
    reminders: TaskReminders.none, // Provide appropriate default value
    category: TaskCategory.none, // Provide appropriate default value
    reccuring: TaskReccuring.none, // Provide appropriate default value
  );
  // An entity can be an object with methods, or it can be a set of
  // data structures and functions.
  bool get isEmpty => this == Task.empty;


}
