import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/features/tasks/domain/validators/description_validator.dart';
import 'package:hometasks/src/features/tasks/domain/validators/title_validator.dart';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart' as Description;


void main() {
  group('FormField Tests', () {
    late FormFieldController<String, Title> titleField;

    setUp(() {
      titleField = FormFieldController<String, Title>(
        validateFunction: validateStringToTitle,
        fieldName: 'title',
      );
    });

    tearDown(() {
      titleField.dispose();
    });

    test('FormField Test Title', () async {
      // Arrange
      List<FormFieldModel<Title>> successEventsEmitted=[];
      List<String> errorEvents=[];
      final testTitle = 'MockedTitle';
      titleField.valueStream.listen((event) {
          successEventsEmitted.add(event);
          expect(successEventsEmitted, [isA<FormFieldModel<Title>>()]);
          expect(successEventsEmitted.length,1 );
          expect(titleField.value, isA<Title>() );

      },onError: (error){
        errorEvents.add(error.toString());
      });
      // Act
      titleField.changeValue(testTitle);

      // Introduce a delay to allow the stream to emit events
      await Future.delayed(Duration(milliseconds: 500));
      // Dispose the formField to avoid memory leaks
      titleField.dispose();
    });
    test('Validating description field', () {
      final descriptionField = FormFieldController<String, Description.Description>(
        validateFunction: validateStringToDescription,
        fieldName: 'description',
      );
      List<FormFieldModel<Description.Description>> successEventsEmitted=[];
      List<String> errorEvents=[];
      descriptionField.valueStream.listen((event) {
        successEventsEmitted.add(event);
        expect(successEventsEmitted, [isA<FormFieldModel<Description.Description>>()]);
        expect(successEventsEmitted.length,1 );
        expect(descriptionField.value, isA<Description.Description>() );

      },onError: (error){
        errorEvents.add(error);

      });
      // Change the value to a valid description
      descriptionField.changeValue('Valid Description');

    });
    test('inValidating description field', () {
      final descriptionField = FormFieldController<String, Description.Description>(
        validateFunction: validateStringToDescription,
        fieldName: 'description',
      );
      List<FormFieldModel<Description.Description>> successEventsEmitted=[];
      List<String> errorEvents=[];
      descriptionField.valueStream.listen((event) {
        successEventsEmitted.add(event);


      },onError: (error){
        errorEvents.add(error);
        expect(errorEvents, [isA<String>()]);
        expect(errorEvents.length,1 );
      });
      // Change the value to a valid description
      descriptionField.changeValue('');

    });
  });
}