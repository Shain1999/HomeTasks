import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';
abstract class IChildStepFormFunctions{

  Future<void> OnStepSubmitFunc(OnStepSubmit event, Emitter<ChildStepFormState> emit);

  Future<void> OnStepFailureFunc(OnStepFailure event,
      Emitter<ChildStepFormState> emit);
  Future<void> OnStepSuccessFunc(OnStepSuccess event,
      Emitter<ChildStepFormState> emit);

}
