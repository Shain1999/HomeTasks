// data/remote/data_sources/firebase_user_data_source.dart
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/users/data/remote/models/user_model.dart';

abstract class FirebaseUserDataSource {
  Future<Result<List<UserModel>>> getUsers();
  Future<Result<UserModel?>> getUserById(String userId);
  Future<Result> addUser(UserModel user);
  Future<Result> updateUser(String userId, UserModel updatedUser);
  Future<Result> deleteUser(String userId);
}
