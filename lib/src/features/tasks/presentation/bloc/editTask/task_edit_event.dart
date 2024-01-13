import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hometasks/src/features/tasks/domain/entities/get_task_params_model.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/presentation/filters/task_view_filter.dart';
//template for all TaskEditEvents
abstract class TaskEditEvent extends Equatable{
  const TaskEditEvent();

  @override
  List<Object?> get props => [];
}
//template for OnFieldChanged events inheriting from TaskEdit Event
//each object type will get a different event
class OnFieldChanged extends TaskEditEvent{
  final String fieldName;
  final dynamic value;
  const OnFieldChanged({required this.fieldName,required this.value});
  @override
  List<Object?> get props => [];
}
// when the user navigate to the new or edit screen init the state to fit the desired task
class OnInitAdd extends TaskEditEvent{
  const OnInitAdd();

  @override
  List<Object?> get props => [];
}
// when the user navigate to the new or edit screen init the state to fit the desired task
class OnInitEdit extends TaskEditEvent{
  const OnInitEdit();

  @override
  List<Object?> get props => [];
}
class OnFormSubmitUpdate extends TaskEditEvent{
  const OnFormSubmitUpdate();

  @override
  List<Object?> get props => [];
}
class OnFormSubmitAdd extends TaskEditEvent{
  const OnFormSubmitAdd();

  @override
  List<Object?> get props => [];
}


class OnTextFieldChange extends OnFieldChanged {
  final String fieldName;
  final String value;

  const OnTextFieldChange({required this.fieldName, required this.value})
      : super(fieldName: fieldName, value: value);

  @override
  List<Object?> get props => [fieldName, value];
}
class OnDateFieldChange extends OnFieldChanged {
  final String fieldName;
  final DateTime value;

  const OnDateFieldChange({required this.fieldName, required this.value})
      : super(fieldName: fieldName, value: value);

  @override
  List<Object?> get props => [fieldName, value];
}
class OnListFieldChange extends OnFieldChanged {
  final String fieldName;
  final Iterable value;

  const OnListFieldChange({required this.fieldName, required this.value})
      : super(fieldName: fieldName, value: value);

  @override
  List<Object?> get props => [fieldName, value];
}
