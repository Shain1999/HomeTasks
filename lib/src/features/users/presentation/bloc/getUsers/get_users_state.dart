import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/presentation/filters/task_view_filter.dart';
import 'package:hometasks/src/features/users/domain/entities/user_entity.dart';

enum GetUsersStatus { initial, loading, success, failure }
class  GetUsersState extends Equatable {
  const GetUsersState({
    this.status = GetUsersStatus.initial,
    this.users = const [],
    this.errorMessage
  });

  final GetUsersStatus status;
  final String? errorMessage;
  final List<UserEntity> users;


  GetUsersState copyWith({
    GetUsersStatus Function()? status,
    List<UserEntity> Function()? users,
    String? errorMessage
  }) {
    return GetUsersState(
        status: status != null ? status() : this.status,
        users: users != null ? users() : this.users,
        errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [
    status,
    users,
    errorMessage
  ];
}