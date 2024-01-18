// data/repositories/user_repository_impl.dart
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/users/data/local/data_sources/user_local_data_source.dart';
import 'package:hometasks/src/features/users/data/remote/data_sources/firebase_users_data_source.dart';
import 'package:hometasks/src/features/users/data/remote/models/user_model.dart';
import 'package:hometasks/src/features/users/domain/entities/user_entity.dart';
import 'package:hometasks/src/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;
  final FirebaseUserDataSource remoteDataSource;

  UserRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Result<List<UserEntity>>> getUsers() async {
    try {
      // Attempt to get users from the remote data source
      final remoteResult = await remoteDataSource.getUsers();

      if (remoteResult.isSuccess) {
        // Update local storage with the remote data
        remoteResult.value?.forEach((userModel) async {
          await localDataSource.saveUser(userModel);
        });

        // Map the result to entities
        final entities = remoteResult.value!.map((userModel) => userModel.toEntity()).toList();
        return Result.success(value: entities);
      } else {
        // If remote fails, try to get users from local storage
        final localResult = await localDataSource.getAllUsers();

        if (localResult.isSuccess) {
          return Result.success(value: localResult.value!.map((model) =>model.toEntity() ).toList());
        } else {
          // If local fails as well, return the remote error
          return Result<List<UserEntity>>.failure(
            serverError: remoteResult.serverError,
            message: remoteResult.message,
            internalCode: remoteResult.internalCode,
          );
        }
      }
    } catch (error) {
      return Result<List<UserEntity>>.failure(message: error.toString());
    }
  }

  @override
  Future<Result<UserEntity?>> getUserById(String userId) async {
    try {
      // Attempt to get the user from the remote data source
      final remoteResult = await remoteDataSource.getUserById(userId);

      if (remoteResult.isSuccess) {
        // Update local storage with the remote data
        if (remoteResult.value != null) {
          await localDataSource.saveUser(remoteResult.value!);
        }

        // Map the result to an entity
        final entity = remoteResult.value?.toEntity();
        return Result.success(value: entity);
      } else {
        // If remote fails, try to get the user from local storage
        final localResult = await localDataSource.getUser(userId);

        if (localResult.isSuccess) {
          return Result.success(value: localResult.value?.toEntity());
        } else {
          // If local fails as well, return the remote error
          return Result<UserEntity?>.failure(
            serverError: remoteResult.serverError,
            message: remoteResult.message,
            internalCode: remoteResult.internalCode,
          );
        }
      }
    } catch (error) {
      return Result<UserEntity?>.failure(message: error.toString());
    }
  }
  @override
  Future<Result> updateUser(String userId, UserEntity updatedUser) async {
    try {
      // Update user in remote data source
      await remoteDataSource.updateUser(userId, UserModel.fromEntity(updatedUser));

      // Save updated user to local storage
      await localDataSource.saveUser(UserModel.fromEntity(updatedUser));

      return Result.success();
    } catch (error) {
      return Result.failure(message: error.toString());
    }
  }

  @override
  Future<Result> deleteUser(String userId) async {
    try {
      // Delete user from remote data source
      await remoteDataSource.deleteUser(userId);

      // Delete user from local storage
      await localDataSource.deleteUser(userId);

      return Result.success();
    } catch (error) {
      return Result.failure(message: error.toString());
    }
  }
  @override
  Future<Result> addUser(UserEntity user) async {
    try {
      // Add user to remote data source
      await remoteDataSource.addUser(UserModel.fromEntity(user));

      // Save user to local storage
      await localDataSource.saveUser(UserModel.fromEntity(user));

      return Result.success();
    } catch (error) {
      return Result.failure(message: error.toString());
    }
  }

// Other methods remain similar, incorporating local storage calls where necessary
}
