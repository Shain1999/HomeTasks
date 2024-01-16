// Create a transformer for the Genereic Types
import 'dart:async';

import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';

StreamTransformer<T, FormFieldModel<T>> createGenericTransformer<T>() {
  return StreamTransformer<T, FormFieldModel<T>>.fromHandlers(
    handleData: (value, sink) {
      try {
        sink.add(FormFieldModel(
          value: value,
          status: FieldStatus.valid,
          errorMessage: '',
        ));
        // You might want to handle the status outside of this function based on the validation result.
      } catch (error) {
        sink.addError(FormFieldModel(
          value: null, // or any default value you want to use in case of error
          status: FieldStatus.invalid,
          errorMessage: 'Invalid ${value.runtimeType}: $error',
        ));
      }
    },
  );
}
dynamic validateGenericTypes(dynamic args){
  return args;
}