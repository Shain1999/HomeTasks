import 'dart:async';

import 'package:hometasks/src/features/tasks/domain/validators/description_validator.dart';
import 'package:hometasks/src/features/tasks/domain/validators/regular_validator.dart';
import 'package:hometasks/src/features/tasks/domain/validators/title_validator.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';
import 'package:test/test.dart';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart' as Description;

void main() {
  group('FirstStepFormState tests', () {
    test('Initial state', () {
      final initialState = FirstStepFormState();

      expect(initialState.status, ChildStepFormStatus.initial);
      expect(initialState.step, CurrentStep.step1);
      expect(initialState.titleField, isA<FormFieldController<String, Title>>());
      expect(initialState.descriptionField, isA<FormFieldController<String, Description.Description>>());
      expect(initialState.categoryField, isA<FormFieldController<TaskCategory, TaskCategory>>());
      expect(initialState.priorityField, isA<FormFieldController<TaskPriority, TaskPriority>>());
      expect(initialState.errorMessage, isNull);
    });

    test('CopyWith method', () {
      final initialState = FirstStepFormState();
      final updatedState = initialState.copyWith(
        status: () => ChildStepFormStatus.success,
        errorMessage: 'Test Error',
      );

      expect(updatedState.status, ChildStepFormStatus.success);
      expect(updatedState.errorMessage, 'Test Error');
      // Make sure other fields are unchanged
      expect(updatedState.step, initialState.step);
      expect(updatedState.titleField, initialState.titleField);
      expect(updatedState.descriptionField, initialState.descriptionField);
      expect(updatedState.categoryField, initialState.categoryField);
      expect(updatedState.priorityField, initialState.priorityField);
    });

    test('GetCurrentValuesToMap method', () async {
      final formState = FirstStepFormState(
        titleField: FormFieldController<String, Title>(validateFunction: validateStringToTitle, fieldName: 'title'),
        descriptionField: FormFieldController<String, Description.Description>(validateFunction: validateStringToDescription, fieldName: 'description'),
        categoryField: TaskCategory.none,
        priorityField: TaskPriority.none
      );
      List<FormFieldModel<Title>> successEventsEmitted=[];
      List<String> errorEvents=[];

      formState.titleField?.valueStream.listen((event) {
        successEventsEmitted.add(event);
        expect(successEventsEmitted, [isA<FormFieldModel<Title>>()]);
        expect(successEventsEmitted.length,1 );
        expect( formState.titleField?.value, isA<Title>() );

      },onError: (error){
        errorEvents.add(error.toString());
      });
      formState.titleField?.changeValue('Test Title');
      formState.descriptionField?.changeValue('Test Description');

      await Future.delayed(Duration(milliseconds: 500));
      final valuesMap = formState.getCurrentValuesToMap();

      expect(valuesMap['title'], 'Test Title');
       expect(valuesMap['description'], 'Test Description');

    });
  });
}
