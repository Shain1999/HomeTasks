import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/validators/title_validator.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';

class FirstStepFormState extends ChildStepFormState {
  FirstStepFormState({
    this.step = CurrentStep.step1,
    this.status = ChildStepFormStatus.initial,
    this.errorMessage,
    FormField<String, Title>? titleField, // Remove the factory-created titleField
  }) : titleField = titleField ?? FormField<String, Title>(
    transformer: createTitleTransformer(),
    fieldName: 'title',
  ),
        super();

  final ChildStepFormStatus status;
  final FormField<String, Title>? titleField;
  final String? errorMessage;
  final CurrentStep step;

  // Static method to create an initial state
  factory FirstStepFormState.initial() {
    return FirstStepFormState(
      status: ChildStepFormStatus.initial,
      titleField: FormField<String, Title>(
        transformer: createTitleTransformer(),
        fieldName: 'title',
      ),
    );
  }
  FirstStepFormState copyWith({
    ChildStepFormStatus Function()? status,
    FormField<String, Title> Function()? titleField,
    String? errorMessage
  }) {
    return FirstStepFormState(
        status: status != null ? status() : this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        titleField: titleField != null ? titleField() : this.titleField,
        step: this.step

    );
  }

  @override
  List<Object?> get props =>
      [
        status,
        titleField,
        errorMessage
      ];

}
