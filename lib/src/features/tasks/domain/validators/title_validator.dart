// Create a transformer for the Title
import 'dart:async';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';

StreamTransformer<String, Title> createTitleTransformer() {
  return StreamTransformer<String, Title>.fromHandlers(
    handleData: (title, sink) {
      try {
        final titleObject = Title.create(title);
        sink.add(titleObject);
        // You might want to handle the status outside of this function based on the validation result.
      } catch (error) {
        sink.addError('Invalid title: $error');
      }
    },
  );
}
