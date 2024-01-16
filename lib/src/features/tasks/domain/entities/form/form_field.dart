import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
// this class create a form field that accepts an input type and a return type for the value
// this class accepts a transformer function that acts on every change to the input stream and produce
// the desired return type
// class FormField<InputType, ReturnType> extends Equatable {
//    final _valueController = StreamController<InputType>();
//   //final _valueController = BehaviorSubject<InputType>();
//
//   Stream<ReturnType> get valueStream =>
//        _valueController.stream.transform(_transformer).debounceTime(const Duration(milliseconds: 300));
//
//   ReturnType? _value;
//   FieldStatus _status;
//
//   final String? labelName;
//   final StreamTransformer<InputType, ReturnType> _transformer;
//   final String fieldName;
//
//   FormField({
//     required StreamTransformer<InputType, ReturnType> transformer,
//     required this.fieldName,
//     this.labelName
//   })
//       : _transformer = transformer,
//         _status=FieldStatus.empty;
//
//   Future<ReturnType> get value async => await _valueController.stream.transform(_transformer).first;
//
//   String get label => labelName ?? fieldName;
//
//   FieldStatus? get status => _status;
//
//   void changeValue(InputType newValue) {
//     _valueController.sink.add(newValue);
//
//   }
//
//   void setStatus(FieldStatus status) {
//     _status=status;
//   }
//
//   void dispose() {
//     _valueController.close();
//   }
//
//   @override
//   List<Object?> get props => [_valueController,_value,_status,_transformer,label,status,fieldName,labelName,valueStream];
//
// }
//
// enum FieldStatus { empty, valid, invalid }
class FormFieldModel<ReturnType> {
  final ReturnType? value;
  final FieldStatus status;
  final String errorMessage;

  FormFieldModel({
    required this.value,
    required this.status,
    required this.errorMessage,
  });
}

class FormFieldController<InputType, ReturnType> extends Equatable {
  final _valueController = StreamController<InputType>.broadcast();
  final _value = BehaviorSubject<ReturnType>();
  final _status = BehaviorSubject<FieldStatus>();
  final _errorMessage = BehaviorSubject<String>();

  final String? labelName;
  final Function(InputType arg) _validateFunction;
  final String fieldName;

  FormFieldController({
    required Function(InputType arg) validateFunction,
    required this.fieldName,
    this.labelName,
  }) : _validateFunction = validateFunction;

  Stream<FormFieldModel<ReturnType>> get valueStream => _valueController.stream.transform(createTransformer()).debounceTime(const Duration(milliseconds: 300));

  ReturnType get value => _value.value;
  FieldStatus get status => _status.value;
  String get errorMessage => _errorMessage.value;

  String get label => labelName ?? fieldName;

  void changeValue(InputType? newValue) {
        _valueController.sink.add(newValue!);
  }

  void dispose() {
    _valueController.close();
  }
  StreamTransformer<InputType, FormFieldModel<ReturnType>> createTransformer() {
    return StreamTransformer<InputType, FormFieldModel<ReturnType>>.fromHandlers(
      handleData: (obj, sink) {
        try {
          final ReturnType objAfterVal = _validateFunction(obj);
          sink.add(FormFieldModel<ReturnType>(
            value: objAfterVal,
            status: FieldStatus.valid,
            errorMessage: '',
          ));
          _value.add(objAfterVal);
          // You might want to handle the status outside of this function based on the validation result.
        } catch (error) {
          sink.addError('Invalid ${ReturnType.runtimeType}: ${error.toString()}');
          _status.add(FieldStatus.invalid);
          _errorMessage.add(error.toString());
        }
      },
    );
  }

  @override
  List<Object?> get props => [
    _valueController,
    _value,
    label,
    valueStream,
    fieldName,
    labelName,
  ];
}

enum FieldStatus { empty, valid, invalid }
