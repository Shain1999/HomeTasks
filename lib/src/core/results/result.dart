import 'package:equatable/equatable.dart';
import 'package:hometasks/src/core/errors/error.dart';

class Result<T> extends Equatable  {
  final String? message;
  final String? internalCode;
  final bool isSuccess;
  final T? value;
  final ServerError? serverError;
  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType \n Success:  $isSuccess \n internalCode: $internalCode \n message: $internalCode ';



  const Result._({this.message,required this.isSuccess,this.value,this.internalCode,this.serverError});

  factory Result.success({
    String? message,
    String? internalCode,
    T? value,
  }) {
    return Result._(message: message, isSuccess: true,value: value,internalCode: internalCode );
  }
  factory Result.failure({
    String? message,
    String? internalCode,
    ServerError? serverError,
    T? value,
  }){
    return Result._(message: message, isSuccess: false,value: value,internalCode: internalCode,serverError: serverError );
  }
}