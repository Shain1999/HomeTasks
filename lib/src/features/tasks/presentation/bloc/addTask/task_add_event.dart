import 'package:equatable/equatable.dart';

//template for all TaskEditEvents
abstract class TaskAddEvent extends Equatable{
  const TaskAddEvent();

  @override
  List<Object?> get props => [];
}
//template for OnFieldChanged events inheriting from TaskEdit Event
//each object type will get a different event
class OnFieldChanged extends TaskAddEvent{
  final String fieldName;
  final dynamic value;
  const OnFieldChanged({required this.fieldName,required this.value});
  @override
  List<Object?> get props => [];
}
// when the user navigate to the new or edit screen init the state to fit the desired task
class OnInit extends TaskAddEvent{
  const OnInit();

  @override
  List<Object?> get props => [];
}
class OnFormSubmit extends TaskAddEvent{
  const OnFormSubmit();

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
class OnDateFieldChange extends OnFieldChanged{
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
