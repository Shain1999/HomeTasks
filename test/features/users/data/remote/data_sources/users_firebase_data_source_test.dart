import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/features/users/data/remote/data_sources/firebase_users_data_source_impl.dart';
import 'package:hometasks/src/features/users/data/remote/models/user_model.dart';


void main() {
  late FirebaseUserDataSourceImpl firebaseUserDataSource;
  late FirebaseFirestore mockFirestore;

  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    firebaseUserDataSource = FirebaseUserDataSourceImpl(firestore: mockFirestore);
  });
  group('FirebaseUserDataSourceImpl', () {
    final userModelJson1 = {
      'id': '1',
      'name': 'John Doe',
      'email': 'john@example.com'
    };
    final userModelJson2 = {
      'id': '2',
      'name': 'Joh123n Doe',
      'email': 'john@123example.com'
    };


    test('getUsers - success', () async {
      //arrange
      await mockFirestore.collection('users').doc('1').set(userModelJson1);
      await mockFirestore.collection('users').doc('2').set(userModelJson2);
      //act
      final result = await firebaseUserDataSource.getUsers();
      // Assert
      expect(result.isSuccess, true);
      expect(result.value, isA<List<UserModel>>());
      expect(result.internalCode, isNull);
      expect(result.message, isNull);
      expect(result.serverError, isNull);

    });

    // Add tests for updateUser and deleteUser in a similar manner
  });
}
