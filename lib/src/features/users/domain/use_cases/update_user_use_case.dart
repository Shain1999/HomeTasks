// domain/usecases/update_user_use_case.dart
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/users/domain/entities/user_entity.dart';
import 'package:hometasks/src/features/users/domain/repositories/user_repository.dart';

class UpdateUserUseCase {
  final UserRepository userRepository;

  UpdateUserUseCase({required this.userRepository});

  Future<Result> call(String userId, UserEntity updatedUser) async {
    return await userRepository.updateUser(userId, updatedUser);
  }
}
