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
    FormFieldController<List<String>, List<String>>? assignedUserUidsField,
    FormFieldController<List<String>, List<String>>? notesField,
    FormFieldController<List<String>, List<String>>? commentsField,
    FormFieldController<int, Score>? scoreField
  })
      :assignedUserUidsField = assignedUserUidsField ??
      FormFieldController<List<String>, List<String>>(
          validateFunction: validateStringList,
          labelName: 'Assigned Users',
          fieldName: 'assignedUserUids'),
        notesField = notesField ??
            FormFieldController<List<String>, List<String>>(
                validateFunction: validateStringList,
                fieldName: 'notes'),
        commentsField = commentsField ??
            FormFieldController<List<String>, List<String>>(
                validateFunction: validateStringList,
                fieldName: 'comments'),
        scoreField = scoreField ??
            FormFieldController<int, Score>(
                validateFunction: validateIntToScore,
                fieldName: 'score'),
        super();
  final CurrentStep step;
  final ChildStepFormStatus status;
  final FormFieldController<List<String>, List<String>>? assignedUserUidsField;
  final FormFieldController<List<String>, List<String>>? notesField;
  final FormFieldController<List<String>, List<String>>? commentsField;
  final FormFieldController<int, Score>? scoreField;
  final String? errorMessage;


  @override
  ThirdStepFormState copyWith({
    ChildStepFormStatus Function()? status,
    FormFieldController<List<String>, List<String>>Function()? assignedUserUidsField,
    FormFieldController<List<String>, List<String>>Function()? notesField,
    FormFieldController<List<String>, List<String>>Function()? commentsField,
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

  Map<String, dynamic> getCurrentValuesToMap() {
    return {
      'assignedUserUids': assignedUserUidsField?.value,
      'notes': notesField?.value,
      'comments': commentsField?.value,
      'score': scoreField?.value,
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
