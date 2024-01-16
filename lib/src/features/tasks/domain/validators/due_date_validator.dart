// Create a transformer for the Title
import 'dart:async';

import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';

StreamTransformer<DateTime,FormFieldModel<DateTime>> createDueDateTransformer() {
  return StreamTransformer<DateTime, FormFieldModel<DateTime>>.fromHandlers(
    handleData: (date, sink) {
      try {
        if(DateTime.now().isAfter(date)){
          sink.addError('Invalid Date: date cannot be in the past');
          return;
        }
        sink.add(FormFieldModel(
          value: date,
          status: FieldStatus.valid,
          errorMessage: '',
        ));
        // You might want to handle the status outside of this function based on the validation result.
      } catch (error) {
        sink.addError(FormFieldModel(
          value: null, // or any default value you want to use in case of error
          status: FieldStatus.invalid,
          errorMessage: 'Invalid ${date.runtimeType}: $error',
        ));
      }
    },
  );
}
DateTime validateDateTime(DateTime arg){
    if (DateTime.now().isAfter(arg)) {
      throw ArgumentError('Invalid Date: date cannot be in the past');
    }
  return arg;
}