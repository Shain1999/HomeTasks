// domain/repositories/user_repository.dart
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/users/domain/entities/user_entity.dart';


abstract class UserRepository {
  Future<Result<List<UserEntity>>> getUsers();
  Future<Result<UserEntity?>> getUserById(String userId);
  Future<Result> addUser(UserEntity user);
  Future<Result> updateUser(String userId, UserEntity updatedUser);
  Future<Result> deleteUser(String userId);
}