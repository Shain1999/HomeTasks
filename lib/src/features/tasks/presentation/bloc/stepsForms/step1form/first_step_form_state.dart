import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/validators/description_validator.dart';
import 'package:hometasks/src/features/tasks/domain/validators/title_validator.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';

class FirstStepFormState extends ChildStepFormState {
  FirstStepFormState({
    this.step = CurrentStep.step1,
    this.status = ChildStepFormStatus.initial,
    this.errorMessage,
    FormFieldController<String, Title>? titleField,
    FormFieldController<String, Description>? descriptionField,
    this.categoryField = TaskCategory.none,
    this.priorityField=TaskPriority.none,
  })
      : titleField = titleField ?? FormFieldController<String, Title>(
      validateFunction: validateStringToTitle,
      fieldName: 'title'),
        descriptionField = descriptionField ??
            FormFieldController<String, Description>(
                validateFunction: validateStringToDescription,
                fieldName: 'description'),
        super();

  @override
  final ChildStepFormStatus status;
  final FormFieldController<String, Title>? titleField;
  final FormFieldController<String, Description>? descriptionField;
  final TaskCategory categoryField;
  final TaskPriority priorityField;
  @override
  final String? errorMessage;
  @override
  final CurrentStep step;


  FirstStepFormState copyWith({
    ChildStepFormStatus Function()? status,
    FormFieldController<String, Title> Function()? titleField,
    FormFieldController<String, Description>Function()? descriptionField,
    TaskCategory Function()? categoryField,
    TaskPriority Function()? priorityField,
    String? errorMessage
  }) {
    return FirstStepFormState(
        status: status != null ? status() : this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        titleField: titleField != null ? titleField() : this.titleField,
        categoryField: categoryField != null ? categoryField() : this
            .categoryField,
        priorityField: priorityField != null ? priorityField() : this
            .priorityField,
        descriptionField: descriptionField != null ? descriptionField() : this
            .descriptionField,
        step: this.step

    );
  }

  bool get isFormValid =>
      titleField!.status == FieldStatus.valid &&
          categoryField != TaskCategory.none &&
          priorityField != TaskPriority.none &&
          descriptionField!.status == FieldStatus.valid;

  // Map<String, dynamic> toMap(){
  //   return {
  //     'title':titleField?.value ?? '',
  //     'description':descriptionField?.value ?? '',
  //     'category':  categoryField?.value ?? TaskCategory.none,
  //     'priority':  priorityField?.value ?? TaskPriority.none,
  //   };
  // }
  Map<String, dynamic> getCurrentValuesToMap() {
    return {
      'title': titleField?.value.value ?? '',
      'description': descriptionField?.value.value ?? '',
      'category': categoryField ,
      'priority': priorityField ,
    };
  }

  @override
  List<Object?> get props =>
      [
        status,
        titleField,
        descriptionField,
        categoryField,
        priorityField,
        errorMessage
      ];


}
