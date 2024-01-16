import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';

//template for all MainFormEvents
abstract class MainFormEvent extends Equatable{
  const  MainFormEvent();

  @override
  List<Object?> get props => [];
}

class OnInitEvent extends MainFormEvent{
  const OnInitEvent();

  @override
  List<Object?> get props => [];
}
class OnStepSubmit extends MainFormEvent{
  final CurrentStep step;
  const OnStepSubmit({required this.step});

  @override
  List<Object?> get props => [];
}
class OnStepFailure extends MainFormEvent{
  final CurrentStep step;
  const OnStepFailure({required this.step});

  @override
  List<Object?> get props => [];
}
class OnStepSuccess extends MainFormEvent{
  final CurrentStep step;
  const OnStepSuccess({required this.step});

  @override
  List<Object?> get props => [];
}

class OnFormSubmitEvent extends MainFormEvent{
  const OnFormSubmitEvent();

  @override
  List<Object?> get props => [];
}
class OnFormSubmitSuccess extends MainFormEvent{
  const OnFormSubmitSuccess();

  @override
  List<Object?> get props => [];
}
class OnFormSubmitFailure extends MainFormEvent{
  const OnFormSubmitFailure();

  @override
  List<Object?> get props => [];
}