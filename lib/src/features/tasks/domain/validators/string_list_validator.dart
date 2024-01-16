import 'dart:async';
StreamTransformer<List<String>, List<String>> createArrayTransformer() {
  return StreamTransformer<List<String>, List<String>>.fromHandlers(
    handleData: (values, sink) {
      final List<String> validValues = [];
      for (var value in values) {
        try {
          // Apply your validation logic here for each value in the array
          // For example, creating a Title object
          validValues.add(value);
        } catch (error) {
          // Handle validation errors and add them to the sink
          sink.addError('Invalid value: $error');
        }
      }
      sink.add(validValues);
    },
  );
}