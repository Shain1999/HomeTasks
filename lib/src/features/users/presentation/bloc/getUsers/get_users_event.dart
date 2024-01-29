import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/users/domain/entities/user_entity.dart';

abstract class GetUsersEvent extends Equatable{
  const GetUsersEvent();

  @override
  List<Object?> get props => [];
}
class OnGetUsers extends GetUsersEvent{
  const OnGetUsers();

  @override
  List<Object?> get props => [];
}

class OnGetUsersFailed extends GetUsersEvent{
  const OnGetUsersFailed();

  @override
  List<Object?> get props => [];
}

class OnGetUsersSuccess extends GetUsersEvent{
  final List<UserEntity> usersList;

  const OnGetUsersSuccess({required this.usersList});

  @override
  List<Object?> get props => [];
}