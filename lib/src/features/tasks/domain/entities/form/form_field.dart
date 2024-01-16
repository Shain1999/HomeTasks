import 'dart:async';

import 'package:rxdart/rxdart.dart';
// this class create a form field that accepts an input type and a return type for the value
//this class accepts a transformer function that acts on every change to the input stream and produce
//the desired return type
class FormField<InputType, ReturnType> {
  final _valueController = StreamController<InputType>();

  Stream<ReturnType> get valueStream =>
      _valueController.stream.transform(_transformer).debounceTime(const Duration(milliseconds: 300));

  InputType? _value;
  FieldStatus _status;

  final String? labelName;
  final StreamTransformer<InputType, ReturnType> _transformer;
  final String fieldName;

  FormField({
    required StreamTransformer<InputType, ReturnType> transformer,
    required this.fieldName,
    this.labelName
  })
      : _transformer = transformer,
        _status=FieldStatus.empty;

  InputType? get value => _value;

  String get label => labelName ?? fieldName;

  FieldStatus? get status => _status;

  void changeValue(InputType newValue) {
    _valueController.sink.add(newValue);
  }

  void setStatus(FieldStatus status) {
    _status=status;
  }

  void dispose() {
    _valueController.close();
  }

}

enum FieldStatus { empty, valid, invalid }
