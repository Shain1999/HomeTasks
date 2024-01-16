import 'package:built_value/built_value.dart';

part 'score.g.dart';

// Value object for Score
abstract class Score implements Built<Score, ScoreBuilder> {
  int get value;

  Score._() {
    if(value.isNaN){
    throw ArgumentError('Score cannot be NaN');
  }
    if (value<0) {
      throw ArgumentError('Score cannot less than 0');
    }
  }

  // Expose a static create method
  static Score create(int value) {
    return Score((b) => b
      ..value = value
      );
  }


  factory Score([void Function(ScoreBuilder) updates]) = _$Score;
}