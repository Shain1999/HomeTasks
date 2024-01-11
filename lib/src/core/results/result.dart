import 'package:equatable/equatable.dart';
import 'package:hometasks/src/core/response/http_code.dart';

class Result<T> extends Equatable  {
  final String? message;
  final bool isSuccess;
  final String? internalCode;
  final HttpStatusCode externalCode;
  final T? value;
  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType Success $isSuccess inernalCode $internalCode externalCode $externalCode';



  const Result._({this.message,required this.isSuccess,this.internalCode, required this.externalCode,this.value});


  factory Result.created({
    String? message,
    String? internalCode,
    T? value,
  }) {
    return Result._(message: message, isSuccess: true, internalCode: internalCode, externalCode:HttpStatusCode.created,value: value );
  }
  factory Result.ok({
  String? message,
  String? internalCode,
  T? value,
  }){
    return Result._(message: message, isSuccess: true, internalCode: internalCode, externalCode:HttpStatusCode.ok,value: value );
  }
  factory Result.noContent({
    String? message,
    String? internalCode
  }){
    return Result._(message: message, isSuccess: true, internalCode: internalCode, externalCode:HttpStatusCode.noContent );
  }
  factory Result.badRequest({
    String? message,
    String? internalCode
  }){
    return Result._(message: message, isSuccess: false, internalCode: internalCode, externalCode:HttpStatusCode.badRequest);
  }
  factory Result.unauthorized({
    String? message,
    String? internalCode}){
    return Result._(message: message, isSuccess: false, internalCode: internalCode, externalCode:HttpStatusCode.unauthorized);
  }
  factory Result.internalError({
    String? message,
    String? internalCode}){
    return Result._(message: message, isSuccess: false, internalCode: internalCode, externalCode:HttpStatusCode.internalServerError );
  }
  factory Result.notFound({
    String? message,
    String? internalCode}){
    return Result._(message: message, isSuccess: false, internalCode: internalCode, externalCode:HttpStatusCode.notFound);
  }
}