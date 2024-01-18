// domain/usecases/delete_user_use_case.dart
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/users/domain/repositories/user_repository.dart';

class DeleteUserUseCase {
  final UserRepository userRepository;

  DeleteUserUseCase({required this.userRepository});

  Future<Result> call(String userId) async {
    return await userRepository.deleteUser(userId);
  }
}
