import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/validators/string_list_validator.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';

class ThirdStepFormState extends ChildStepFormState {
  ThirdStepFormState({
    this.step = CurrentStep.step3,
    this.status = ChildStepFormStatus.initial,
    this.errorMessage,
    FormField<List<String>, List<String>>? assignedUserUids,
  })
      :assignedUserUids = assignedUserUids ??
      FormField<List<String>, List<String>>(
        transformer: createArrayTransformer(),
        fieldName: 'Assigned Users',
      ),
        super();
  final CurrentStep step;
  final ChildStepFormStatus status;
  final FormField<List<String>, List<String>>? assignedUserUids;
  final String? errorMessage;


  @override
  ThirdStepFormState copyWith({
    ChildStepFormStatus Function()? status,
    FormField<List<String>, List<String>>Function()? assignedUserUids,
    String? errorMessage
  }) {
    return ThirdStepFormState(
        step: this.step,
        status: status != null ? status() : this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        assignedUserUids: assignedUserUids != null ? assignedUserUids() : this
            .assignedUserUids
    );
  }

  @override
  List<Object?> get props =>
      [
        status,
        assignedUserUids,
        errorMessage
      ];

}
