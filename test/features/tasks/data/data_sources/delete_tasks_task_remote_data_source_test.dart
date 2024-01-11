import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/features/tasks/data/data_sources/firesbase_task_data_source.dart';
import 'package:mockito/mockito.dart';
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/core/errors/error_type.dart';
import 'package:hometasks/src/core/errors/task/task_error.dart';

void main() {
  test('Should return success when deleting a task from Firebase', () async {
    // Arrange
    final fakeFirestore = FakeFirebaseFirestore();
    final mockDataSource = FirebaseTaskDataSource(firestore: fakeFirestore);

    final taskId = '1';


    // Act
    final result = await mockDataSource.deleteTask(taskId);

    // Assert
    expect(result.isSuccess, true);
    expect(result.value, isNull);
    expect(result.internalCode, isNull);
    expect(result.message, isNull);
    expect(result.serverError, isNull);
  });


}
