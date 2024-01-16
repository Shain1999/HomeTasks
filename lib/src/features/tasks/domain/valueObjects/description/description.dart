import 'package:built_value/built_value.dart';

part 'description.g.dart';

// Value object for description
abstract class Description implements Built<Description, DescriptionBuilder> {
  String get value;

  Description._() {
    if (value.isEmpty) {
      throw ArgumentError('Description cannot be empty');
    }
    if(value.length>255){
      throw ArgumentError('Description cannot be that long');
    }
  }

  // Expose a static create method
  static Description create(String value) {
    return Description((b) => b
      ..value = value
      );
  }

  // Override toString to return the value implicitly
  @override
  String toString() => value;

  factory Description([void Function(DescriptionBuilder) updates]) = _$Description;
}