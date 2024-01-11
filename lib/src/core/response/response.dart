import 'package:equatable/equatable.dart';
import 'package:hometasks/src/core/response/http_code.dart';

class Response<T> extends Equatable  {
  final String? message;
  final bool isSuccess;
  final T? value;
  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType Success $isSuccess message $message';



  const Response._({this.message,required this.isSuccess,this.value});


  factory Response.success({
    String? message,

    T? value,
  }) {
    return Response._(message: message, isSuccess: true,value: value );
  }
  factory Response.failure({
  String? message,
  T? value,
  }){
    return Response._(message: message, isSuccess: false,value: value );
  }

}