import 'dart:async';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';

StreamTransformer<String, FormFieldModel<Title>> createTitleTransformer() {
  return StreamTransformer<String, FormFieldModel<Title>>.fromHandlers(
    handleData: (title, sink) {
      try {
        final titleObject = Title.create(title);
        sink.add(FormFieldModel(
          value: titleObject,
          status: FieldStatus.valid,
          errorMessage: '',
        ));
        // You might want to handle the status outside of this function based on the validation result.
      } catch (error) {
        sink.addError(FormFieldModel(
          value: null, // or any default value you want to use in case of error
          status: FieldStatus.invalid,
          errorMessage: 'Invalid title: $error',
        ));
      }
    },
  );
}
Title validateStringToTitle(String arg){
    return Title.create(arg);
}