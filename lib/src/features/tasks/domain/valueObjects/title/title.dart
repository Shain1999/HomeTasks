import 'package:built_value/built_value.dart';

part 'title.g.dart';

// Value object representing a Title
abstract class Title implements Built<Title, TitleBuilder> {
  String get value;

  Title._() {
    if (value.isEmpty) {
      throw ArgumentError('Title cannot be empty');
    }
    if (value.length>255) {
      throw ArgumentError('Title cannot be that long');
    }
  }
  // Expose a static create method
  static Title create(String value) {
    return Title((b) => b
      ..value = value
    );
  }
  // Override toString to return the value implicitly
  @override
  String toString() => value;

  // Factory method for creating a Title
  factory Title([void Function(TitleBuilder) updates]) = _$Title;
}
