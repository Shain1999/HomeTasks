// user_local_data_source.dart
import 'package:hive/hive.dart';
import 'package:hometasks/src/core/errors/error.dart';
import 'package:hometasks/src/core/errors/error_type.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/users/data/remote/models/user_model.dart';

class UserLocalDataSource {
  static const _userBoxName = 'userBox';

  Future<Result> saveUser(UserModel user) async {
    try {
      final box = await Hive.openBox<UserModel>(_userBoxName);
      await box.put(user.id, user);
      return Result.success();
    }
    catch(error) {

      return Result.failure(message: error.toString(),internalCode:'localStorage.saveUSer',serverError: ServerError.create(ServerErrorType.internalServerError) );
    }

  }

  Future<Result<UserModel?>> getUser(String id) async {
    try{

    final box = await Hive.openBox<UserModel>(_userBoxName);
    return Result.success(value:box.get(id));
    }
    catch(error){
      return Result<UserModel?>.failure(message: error.toString(),internalCode:'localStorage.getUser',serverError: ServerError.create(ServerErrorType.internalServerError) );
    }
  }

  Future<Result<List<UserModel>>> getAllUsers() async {
    try{
    final box = await Hive.openBox<UserModel>(_userBoxName);
    return Result<List<UserModel>>.success(value:box.values.toList());
    }
    catch(error){
      return Result<List<UserModel>>.failure(message: error.toString(),internalCode:'localStorage.getAllUsers',serverError: ServerError.create(ServerErrorType.internalServerError) );
    }
  }

  Future<Result> deleteUser(String id) async {
    try{

    final box = await Hive.openBox<UserModel>(_userBoxName);
    await box.delete(id);
    return Result.success();
    }
    catch(error){
      return Result.failure(message: error.toString(),internalCode:'localStorage.deleteUser',serverError: ServerError.create(ServerErrorType.internalServerError) );
    }
  }

  Future<Result> saveUsers(List<UserModel> users) async {
    try {
      final box = await Hive.openBox<UserModel>(_userBoxName);
      for (var user in users) {
        await box.put(user.id, user);
      }
      return Result.success();
    } catch (error) {
      return Result.failure(message: error.toString(), internalCode: 'localStorage.saveUsers', serverError: ServerError.create(ServerErrorType.internalServerError));
    }
  }
}
