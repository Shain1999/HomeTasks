import 'package:equatable/equatable.dart';
import 'package:hometasks/src/core/response/http_code.dart';

class Response<T> extends Equatable {


  final String? message;
  final bool isSuccess;
  final String? internalCode;
  final HttpStatusCode externalCode;
  final T? value;

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      '$runtimeType Success $isSuccess inernalCode $internalCode externalCode $externalCode';


  const Response._(
      {this.message, required this.isSuccess, this.internalCode, required this.externalCode, this.value});


  factory Response.created({
    String? message,
    String? internalCode,
    T? value,
  }) {
    return Response._(message: message,
        isSuccess: true,
        internalCode: internalCode,
        externalCode: HttpStatusCode.created,
        value: value);
  }

  factory Response.ok({
    String? message,
    String? internalCode,
    T? value,
  }){
    return Response._(message: message,
        isSuccess: true,
        internalCode: internalCode,
        externalCode: HttpStatusCode.ok,
        value: value);
  }

  factory Response.noContent({
    String? message,
    String? internalCode
  }){
    return Response._(message: message,
        isSuccess: true,
        internalCode: internalCode,
        externalCode: HttpStatusCode.noContent);
  }

  factory Response.badRequest({
    String? message,
    String? internalCode
  }){
    return Response._(message: message,
        isSuccess: false,
        internalCode: internalCode,
        externalCode: HttpStatusCode.badRequest);
  }

  factory Response.unauthorized({
    String? message,
    String? internalCode}){
    return Response._(message: message,
        isSuccess: false,
        internalCode: internalCode,
        externalCode: HttpStatusCode.unauthorized);
  }

  factory Response.internalError({
    String? message,
    String? internalCode}){
    return Response._(message: message,
        isSuccess: false,
        internalCode: internalCode,
        externalCode: HttpStatusCode.internalServerError);
  }

  factory Response.notFound({
    String? message,
    String? internalCode}){
    return Response._(message: message,
        isSuccess: false,
        internalCode: internalCode,
        externalCode: HttpStatusCode.notFound);
  }
}