import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/validators/due_date_validator.dart';
import 'package:hometasks/src/features/tasks/domain/validators/title_validator.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';

class SecondStepFormState extends ChildStepFormState {
  SecondStepFormState({
    this.step = CurrentStep.step2,
    this.status = ChildStepFormStatus.initial,
    this.errorMessage,
    FormField<DateTime, DateTime>? dueDate
  })
      :dueDate =dueDate ?? FormField<DateTime, DateTime>(
    transformer: createDueDateTransformer(),
    fieldName: 'dueDate',
  ),
        super();
  final CurrentStep step;
  final ChildStepFormStatus status;
  final FormField<DateTime, DateTime>? dueDate;
  final String? errorMessage;

  @override
  SecondStepFormState copyWith({

    ChildStepFormStatus Function()? status,
    FormField<DateTime, DateTime> Function()? dueDate,
    String? errorMessage
  }) {
    return SecondStepFormState(
        status: status != null ? status() : this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        dueDate: dueDate != null ? dueDate() : this.dueDate,
        step: this.step
    );
  }

  @override
  List<Object?> get props =>
      [
        status,
        dueDate,
        errorMessage
      ];

}
