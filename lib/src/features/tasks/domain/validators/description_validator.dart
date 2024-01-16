// Create a transformer for the Description
import 'dart:async';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart';

StreamTransformer<String, FormFieldModel<Description>> createDescriptionTransformer() {
  return StreamTransformer<String, FormFieldModel<Description>>.fromHandlers(
    handleData: (description, sink) {
      try {
        final descriptionObject = Description.create(description);
        sink.add(FormFieldModel(
          value: descriptionObject,
          status: FieldStatus.valid,
          errorMessage: '',
        ));
        // You might want to handle the status outside of this function based on the validation result.
      } catch (error) {
        sink.addError(FormFieldModel(
          value: null, // or any default value you want to use in case of error
          status: FieldStatus.invalid,
          errorMessage: 'Invalid Description: $error',
        ));
      }
    },
  );
}
Description validateStringToDescription(String arg){
  return Description.create(arg);
}