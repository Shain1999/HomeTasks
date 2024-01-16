import 'package:equatable/equatable.dart';

//template for all TaskEditEvents
abstract class TaskEvent extends Equatable{
  const TaskEvent();

  @override
  List<Object?> get props => [];
}
//template for OnFieldChanged events inheriting from TaskEdit Event
//each object type will get a different event
class OnFieldChangedEvent extends TaskEvent{
  final String fieldName;
  final dynamic value;
  const OnFieldChangedEvent({required this.fieldName,required this.value});
  @override
  List<Object?> get props => [];
}
// when the user navigate to the new or edit screen init the state to fit the desired task
class OnInitEvent extends TaskEvent{
  const OnInitEvent();

  @override
  List<Object?> get props => [];
}

class OnFormSubmitEvent extends TaskEvent{
  const OnFormSubmitEvent();

  @override
  List<Object?> get props => [];
}

class OnTextFieldChangeEvent extends OnFieldChangedEvent {
  final String fieldName;
  final String value;

  const OnTextFieldChangeEvent({required this.fieldName, required this.value})
      : super(fieldName: fieldName, value: value);

  @override
  List<Object?> get props => [fieldName, value];
}
class OnDateFieldChangeEvent extends OnFieldChangedEvent {
  final String fieldName;
  final DateTime value;

  const OnDateFieldChangeEvent({required this.fieldName, required this.value})
      : super(fieldName: fieldName, value: value);

  @override
  List<Object?> get props => [fieldName, value];
}
class OnListFieldChangeEvent extends OnFieldChangedEvent {
  final String fieldName;
  final Iterable value;

  const OnListFieldChangeEvent({required this.fieldName, required this.value})
      : super(fieldName: fieldName, value: value);

  @override
  List<Object?> get props => [fieldName, value];
}
