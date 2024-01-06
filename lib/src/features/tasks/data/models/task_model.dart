import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';


class TaskModel extends Equatable {
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

  const TaskModel(
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
  factory TaskModel.fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return TaskModel(
        id: snap['id'],
        title: snap['title'],
        description: snap['description'],
        completedByUserUids: List.from(snap['completedByUserUids']),
        assignedUserUids: List.from(snap['assignedUserUids']),
        notes: List.from(['notes']),
        comments: List.from(snap['comments']),
        dueDate: snap['dueDate']?.toDate(),
        createdOn: snap['createdOn']?.toDate(),
        modifiedOn: snap['modifiedOn']?.toDate(),
        estimatedTime: snap['estimatedTime']?.toDate(),
        isCompleted: snap['isCompleted'],
        priority: snap['priority'],
        reminders: snap['reminders'],
        category: snap['category'],
        reccuring: snap['reccuring'],
        score: snap['score']);
  }
  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'dueDate': dueDate?.toUtc().toIso8601String(),
      'createdOn': createdOn?.toUtc().toIso8601String(),
      'modifiedOn': modifiedOn?.toUtc().toIso8601String(),
      'estimatedTime': estimatedTime?.toUtc().toIso8601String(),
      'assignedUserUids': assignedUserUids,
      'category': category.index,
      'reccuring': reccuring.index,
      'priority': priority.index,
      'reminders': reminders.index,
      'completedByUserUids': completedByUserUids,
      'notes': notes,
      'comments': comments,
      'score': score,
    };
  }
  Task toEntity() {
    return Task(
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
}
