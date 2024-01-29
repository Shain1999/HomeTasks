import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hometasks/src/core/errors/error.dart';
import 'package:hometasks/src/core/errors/error_type.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/users/data/local/data_sources/user_local_data_source.dart';
import 'package:hometasks/src/features/users/data/remote/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helper.mocks.dart';

// Generate a mock for Hive
//@GenerateMocks([Box])
void main() {
  late UserLocalDataSource userLocalDataSource;
  late Box<UserModel> mockBox;

  setUp(() {
    mockBox = MockBox();
    userLocalDataSource = UserLocalDataSource();
  });

  group('UserLocalDataSource', () {
    final userModel = UserModel(id: '1', name: 'John Doe', email: 'sjsdj');

    test('saveUser - success', () async {
      when(mockBox.put(any, userModel)).thenAnswer((_) async => true);
      when(Hive.openBox<UserModel>("test")).thenAnswer((_) async => mockBox);

      final result = await userLocalDataSource.saveUser(userModel);

      expect(result, Result.success());
    });

    test('saveUser - failure', () async {
      when(mockBox.put(any, userModel)).thenThrow(Exception());
      when(Hive.openBox<UserModel>("test")).thenThrow(Exception());

      final result = await userLocalDataSource.saveUser(userModel);

      expect(result, Result.failure(
        internalCode: 'localStorage.saveUSer',
        serverError: ServerError.create(ServerErrorType.internalServerError),
      ));
    });

    test('getUser - success', () async {
      when(mockBox.get(any)).thenReturn(userModel);
      when(Hive.openBox<UserModel>("test")).thenAnswer((_) async => mockBox);

      final result = await userLocalDataSource.getUser(userModel.id);

      expect(result, Result.success(value: userModel));
    });

    test('getUser - failure', () async {
      when(mockBox.get(any)).thenThrow(Exception());
      when(Hive.openBox<UserModel>("test")).thenThrow(Exception());

      final result = await userLocalDataSource.getUser(userModel.id);

      expect(result, Result.failure(
        internalCode: 'localStorage.getUser',
        serverError: ServerError.create(ServerErrorType.internalServerError),
      ));
    });

    test('getAllUsers - success', () async {
      when(mockBox.values).thenReturn([userModel]);
      when(Hive.openBox<UserModel>("test")).thenAnswer((_) async => mockBox);

      final result = await userLocalDataSource.getAllUsers();

      expect(result, Result.success(value: [userModel]));
    });

    test('getAllUsers - failure', () async {
      when(mockBox.values).thenThrow(Exception());
      when(Hive.openBox<UserModel>("test")).thenThrow(Exception());

      final result = await userLocalDataSource.getAllUsers();

      expect(result, Result.failure(
        internalCode: 'localStorage.getAllUsers',
        serverError: ServerError.create(ServerErrorType.internalServerError),
      ));
    });

    test('deleteUser - success', () async {
      when(mockBox.delete(any)).thenAnswer((_) async => true);
      when(Hive.openBox<UserModel>("test")).thenAnswer((_) async => mockBox);

      final result = await userLocalDataSource.deleteUser(userModel.id);

      expect(result, Result.success());
    });

    test('deleteUser - failure', () async {
      when(mockBox.delete(any)).thenThrow(Exception());
      when(Hive.openBox<UserModel>("test")).thenThrow(Exception());

      final result = await userLocalDataSource.deleteUser(userModel.id);

      expect(result, Result.failure(
        internalCode: 'localStorage.deleteUser',
        serverError: ServerError.create(ServerErrorType.internalServerError),
      ));
    });

    test('saveUsers - success', () async {
      when(mockBox.put(any, userModel)).thenAnswer((_) async => true);
      when(Hive.openBox<UserModel>("test")).thenAnswer((_) async => mockBox);

      final result = await userLocalDataSource.saveUsers([userModel]);

      expect(result, Result.success());
    });

    test('saveUsers - failure', () async {
      when(mockBox.put(any, userModel)).thenThrow(Exception());
      when(Hive.openBox<UserModel>("test")).thenThrow(Exception());

      final result = await userLocalDataSource.saveUsers([userModel]);

      expect(result, Result.failure(
        internalCode: 'localStorage.saveUsers',
        serverError: ServerError.create(ServerErrorType.internalServerError),
      ));
    });
  });
}
