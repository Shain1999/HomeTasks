import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/data/models/task_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/score/score.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';
import 'package:uuid/uuid.dart';

class Task extends Equatable {
  final String id; //id of the task
  final Title title; //title
  final Description description; // description
  final bool isCompleted; // if the task is completed
  final DateTime? dueDate; // when the task is due
  final DateTime? createdOn; //time created
  final Duration? estimatedTime; // how much time it would take
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
  final Score score; // the score of the task

  Task({ String? id,
    required this.title,
    required this.description,
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
    required this.score,
    required this.category,
    required this.reccuring}) :id = id ?? _generateUuid();

  @override
  List<Object?> get props =>
      [
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
  static Task empty = Task(
      title: Title.create('title'),
      description: Description.create('desc'),
      isCompleted: false,
      priority: TaskPriority.none,
      reminders: TaskReminders.none,
      category: TaskCategory.none,
      reccuring: TaskReccuring.none,
      score: Score.create(0)
  );

  factory Task.initial() {
    return Task(
        title: Title.create('title'),
        description: Description.create('desc'),
        isCompleted: false,
        priority: TaskPriority.none,
        reminders: TaskReminders.none,
        category: TaskCategory.none,
        reccuring: TaskReccuring.none,
        score: Score.create(0)
    );
  }

  factory Task.fromModel(TaskModel model) {
    return Task(
      id: model.id,
      title: Title.create(model.title),
      description: Description.create(model.description!),
      isCompleted: model.isCompleted,
      dueDate: model.dueDate,
      createdOn: model.createdOn,
      modifiedOn: model.modifiedOn,
      estimatedTime: model.estimatedTime,
      assignedUserUids: model.assignedUserUids,
      priority: model.priority,
      reminders: model.reminders,
      notes: model.notes,
      comments: model.comments,
      score: Score.create(model.score!),
      category: model.category,
      reccuring: model.reccuring,
      completedByUserUids: model.completedByUserUids,
    );
  }

  // An entity can be an object with methods, or it can be a set of
  // data structures and functions.
  bool get isEmpty => this == Task.empty;

  TaskModel toModel() {
    return TaskModel(
      id: id,
      title: title.value,
      description: description.value,
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
      score: score.value,
      category: category,
      reccuring: reccuring,
      completedByUserUids: completedByUserUids,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title.value,
      'description': description.value,
      'isCompleted': isCompleted,
      'dueDate': dueDate?.toIso8601String(),
      'createdOn': createdOn?.toIso8601String(),
      'modifiedOn': modifiedOn?.toIso8601String(),
      'estimatedTime': estimatedTime?.inMilliseconds,
      'assignedUserUids': assignedUserUids,
      'priority': priority.toString(), // Assuming TaskPriority is an enum
      'reminders': reminders.toString(), // Assuming TaskReminders is an enum
      'notes': notes,
      'comments': comments,
      'score': score.value,
      'category': category.toString(), // Assuming TaskCategory is an enum
      'reccuring': reccuring.toString(), // Assuming TaskReccuring is an enum
      'completedByUserUids': completedByUserUids,
    };
  }

  factory Task.createTaskFromMap(Map<String, dynamic> updatedFields) {
    return Task(
      title: updatedFields['title'] != null
          ? Title.create(updatedFields['title'])
          : Title.create('title'),
      description: updatedFields['description'] != null
          ? Description.create(updatedFields['description'])
          : Description.create('description'),
      isCompleted: updatedFields['isCompleted'] ?? false,
      dueDate: updatedFields['dueDate'],
      createdOn: updatedFields['createdOn'] ?? DateTime.now(),
      modifiedOn: updatedFields['modifiedOn'] ?? DateTime.now(),
      estimatedTime: updatedFields['estimatedTime'],
      assignedUserUids: updatedFields['assignedUserUids'] ?? [],
      priority: updatedFields['priority'] ?? TaskPriority.none,
      reminders: updatedFields['reminders'] ?? TaskReminders.none,
      notes: updatedFields['notes'] ?? [],
      comments: updatedFields['comments'] ?? [],
      score: updatedFields['score'] != null ? Score.create(
          updatedFields['score']) : Score.create(0),
      category: updatedFields['category'] ?? TaskCategory.none,
      reccuring: updatedFields['reccuring'] ?? TaskReccuring.none,
      completedByUserUids: updatedFields['completedByUserUids'] ?? [],
    );
  }

  Task copyWithFromMap(Map<String, dynamic> updatedFields) {
    return Task(
      title: updatedFields['title'] != null
          ? Title.create(updatedFields['title'])
          : title,
      description: updatedFields['description'] != null
          ? Description.create(updatedFields['description']) : description,
      isCompleted: updatedFields['isCompleted'] ?? isCompleted,
      dueDate: updatedFields['dueDate'] ?? dueDate,
      createdOn: updatedFields['createdOn'] ?? createdOn,
      modifiedOn: updatedFields['modifiedOn'] ?? modifiedOn,
      estimatedTime: updatedFields['estimatedTime'] ?? estimatedTime,
      assignedUserUids: updatedFields['assignedUserUids'] ?? assignedUserUids,
      priority: updatedFields['priority'] ?? priority,
      reminders: updatedFields['reminders'] ?? reminders,
      notes: updatedFields['notes'] ?? notes,
      comments: updatedFields['comments'] ?? comments,
      score: updatedFields['score'] != null ? Score.create(
          updatedFields['score']) : score,
      category: updatedFields['category'] ?? category,
      reccuring: updatedFields['reccuring'] ?? reccuring,
      completedByUserUids: updatedFields['completedByUserUids'] ??
          completedByUserUids,
    );
  }

  static String _generateUuid() {
    return Uuid().v4();
  }

}
