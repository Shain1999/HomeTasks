// data/remote/data_sources/firebase_user_data_source_impl.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hometasks/src/core/errors/error.dart';
import 'package:hometasks/src/core/errors/error_type.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/users/data/remote/data_sources/firebase_users_data_source.dart';
import 'package:hometasks/src/features/users/data/remote/models/user_model.dart';

class FirebaseUserDataSourceImpl implements FirebaseUserDataSource {
  final FirebaseFirestore firestore;
  FirebaseUserDataSourceImpl({required this.firestore});

  @override
  Future<Result<List<UserModel>>> getUsers() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('users').get();

      return Result<List<UserModel>>.success(value:querySnapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList());
    } catch (error) {
      return Result<List<UserModel>>.failure(message: error.toString(),internalCode:'firebase.getUsers',serverError: ServerError.create(ServerErrorType.internalServerError) );
    }
  }

  @override
  Future<Result<UserModel?>> getUserById(String userId) async {
    try {
      DocumentSnapshot documentSnapshot = await firestore.collection('users').doc(userId).get();

      if (!documentSnapshot.exists) {
        return Result<UserModel?>.failure(message: 'userNotFound',internalCode:'firebase.getUserById',serverError: ServerError.create(ServerErrorType.notFound) );
      }
      return Result<UserModel?>.success(value:UserModel.fromSnapshot(documentSnapshot));
    } catch (error) {
      return Result<UserModel?>.failure(message: error.toString(),internalCode:'firebase.getUserById',serverError: ServerError.create(ServerErrorType.internalServerError) );
    }
  }

  @override
  Future<Result> addUser(UserModel user) async {
    try {
      await firestore.collection('users').doc(user.id).set({
        'id': user.id,
        'email': user.email,
        'name': user.name,
        'photoURL': user.photoURL,
      });
      return Result.success();
    } catch (error) {
      return Result.failure(message: error.toString(),internalCode:'firebase.addUser',serverError: ServerError.create(ServerErrorType.internalServerError) );
    }
  }

  @override
  Future<Result> updateUser(String userId, UserModel updatedUser) async {
    try {
      await firestore.collection('users').doc(userId).update({
        'name': updatedUser.name,
        'photoURL': updatedUser.photoURL,
      });
      return Result.success();
    } catch (error) {
      return Result.failure(message: error.toString(),internalCode:'firebase.updateUser',serverError: ServerError.create(ServerErrorType.internalServerError) );
    }
  }

  @override
  Future<Result> deleteUser(String userId) async {
    try {
      await firestore.collection('users').doc(userId).delete();
      return Result.success();


    } catch (error) {
      return Result.failure(message: error.toString(),internalCode:'firebase.deleteUser',serverError: ServerError.create(ServerErrorType.internalServerError) );
    }
  }
}
