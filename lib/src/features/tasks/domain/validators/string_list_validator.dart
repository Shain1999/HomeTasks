import 'dart:async';

import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
StreamTransformer<List<String>, FormFieldModel<List<String>>> createArrayTransformer() {
  return StreamTransformer<List<String>, FormFieldModel<List<String>>>.fromHandlers(
    handleData: (values, sink) {
      final List<String> validValues = [];
      for (var value in values) {
        try {
          // Apply your validation logic here for each value in the array
          // For example, creating a Title object
          validValues.add(value);
        } catch (error) {
          // Handle validation errors and add them to the sink
          sink.addError(FormFieldModel(
            value: null, // or any default value you want to use in case of error
            status: FieldStatus.invalid,
            errorMessage: 'Invalid ${value.runtimeType}: $error',
          ));
        }
      }
      sink.add(FormFieldModel(
        value: validValues,
        status: FieldStatus.valid,
        errorMessage: '',
      ));
    },
  );
}
List<String> validateStringList(List<String> args){
  return args;
}