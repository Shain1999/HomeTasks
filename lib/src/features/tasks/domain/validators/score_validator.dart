// Create a transformer for the Score
import 'dart:async';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/score/score.dart';

StreamTransformer<int, FormFieldModel<Score>> createScoreTransformer() {
  return StreamTransformer<int,  FormFieldModel<Score>>.fromHandlers(
    handleData: (score, sink) {
      try {
        final scoreObject = Score.create(score);
        sink.add(FormFieldModel(
          value: scoreObject,
          status: FieldStatus.valid,
          errorMessage: '',
        ));
        // You might want to handle the status outside of this function based on the validation result.
      } catch (error) {
        sink.addError(FormFieldModel(
          value: null, // or any default value you want to use in case of error
          status: FieldStatus.invalid,
          errorMessage: 'Invalid Score: $error',
        ));
      }
    },
  );
}
Score validateIntToScore(int arg){
  return Score.create(arg);
}