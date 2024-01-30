import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/validators/score_validator.dart';
import 'package:hometasks/src/features/tasks/domain/validators/string_list_validator.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/score/score.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';

class ThirdStepFormState extends ChildStepFormState {
  ThirdStepFormState({
    this.step = CurrentStep.step3,
    this.status = ChildStepFormStatus.initial,
    this.errorMessage,
    this.assignedUserUidsField = const [],
    this. notesField=const [],
    this. commentsField=const [],
    FormFieldController<int, Score>? scoreField
  })
      :
        scoreField = scoreField ??
            FormFieldController<int, Score>(
                validateFunction: validateIntToScore,
                fieldName: 'score'),
        super();
  final CurrentStep step;
  final ChildStepFormStatus status;
  final List<String> assignedUserUidsField;
  final List<String> notesField;
  final List<String> commentsField;
  final FormFieldController<int, Score>? scoreField;
  final String? errorMessage;


  @override
  ThirdStepFormState copyWith({
    ChildStepFormStatus Function()? status,
    List<String>Function()? assignedUserUidsField,
    List<String>Function()? notesField,
    List<String>Function()? commentsField,
    FormFieldController<int, Score>Function()? scoreField,
    String? errorMessage
  }) {
    return ThirdStepFormState(
        step: this.step,
        status: status != null ? status() : this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        assignedUserUidsField: assignedUserUidsField != null
            ? assignedUserUidsField()
            : this.assignedUserUidsField,
        notesField: notesField != null ? notesField() : this.notesField,
        commentsField: commentsField != null ? commentsField() : this
            .commentsField,
        scoreField: scoreField != null ? scoreField() : this.scoreField
    );
  }
  bool get isFormValid => scoreField!.status == FieldStatus.valid;

  Map<String, dynamic> getCurrentValuesToMap() {
    return {
      'assignedUserUids': assignedUserUidsField,
      'notes': notesField,
      'comments': commentsField,
      'score': scoreField?.value.value,
    };
  }

  @override
  List<Object?> get props =>
      [
        status,
        assignedUserUidsField,
        notesField,
        commentsField,
        scoreField,
        errorMessage
      ];

}
