// Create a transformer for the Title
import 'dart:async';

StreamTransformer<DateTime,DateTime> createDueDateTransformer() {
  return StreamTransformer<DateTime, DateTime>.fromHandlers(
    handleData: (date, sink) {
      try {
        if(DateTime.now().isAfter(date)){
          sink.addError('Invalid Date: dueOn cannot be in the past');
          return;
        }
        sink.add(date);
        // You might want to handle the status outside of this function based on the validation result.
      } catch (error) {
        sink.addError('Invalid Date: $error');
      }
    },
  );
}
