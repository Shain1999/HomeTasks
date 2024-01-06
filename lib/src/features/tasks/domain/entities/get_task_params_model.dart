import 'package:equatable/equatable.dart';

class GetTaskParams extends Equatable {
  final int? limit;
  final String? currentPageToken;
  final String? orderByField;
  final bool? descending;

  const GetTaskParams(
      {this.limit = 10, this.currentPageToken, this.orderByField = 'createdOn', this.descending = false});


  @override
  List<Object?> get props =>
      [limit, currentPageToken, orderByField, descending];

}