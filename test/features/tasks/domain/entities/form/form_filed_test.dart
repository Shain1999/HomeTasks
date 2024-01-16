import 'dart:async';
import 'package:hometasks/src/features/tasks/domain/validators/title_validator.dart';
import 'package:test/test.dart';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';

void main() {
  group('FormField Tests', () {
    late FormField<String, Title> titleField;

    setUp(() {
      titleField = FormField<String, Title>(
        transformer: createTitleTransformer(),
        fieldName: 'title',
      );
    });

    tearDown(() {
      titleField.dispose();
    });

    test('Initial state', () {
      expect(titleField.value, isNull);
      expect(titleField.status, equals(FieldStatus.empty));
      titleField.dispose();
    });

    test('Valid input', () async {
      const validTitle = 'Valid Title';
      titleField.changeValue(validTitle);

      // Listen for the stream events
      final List<Title> emittedValues = [];
      final List<String?> emittedErrors = [];

      titleField.valueStream.listen(
            (value) {
          emittedValues.add(value);
        },
        onError: (error) {
          emittedErrors.add(error);
        },
        onDone: () {
          // Verify the emitted values
          expect(emittedValues, [isA<Title>()]);

          // Verify the status and error of the form field
        },
      );
      // Wait for the stream to complete (onDone)
      titleField.dispose();
    });
    test('inValid input', () async {
      const invalidTitle = '';
      titleField.changeValue(invalidTitle);

      // Listen for the stream events
      final List<Title> emittedValues = [];
      final List<String?> emittedErrors = [];

      titleField.valueStream.listen(
            (value) {
          emittedValues.add(value);
        },
        onError: (error) {
          emittedErrors.add(error);
        },
        onDone: () {
          // Verify the emitted values
          // expect(emittedValues, [isA<Title>()]);

          // Verify the status and error of the form field
          expect(emittedErrors, [isA<String>()]);
        },
      );
      // Wait for the stream to complete (onDone)
      titleField.dispose();
    });

  });
}
