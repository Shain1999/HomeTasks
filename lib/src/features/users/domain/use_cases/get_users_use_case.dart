// domain/usecases/get_users_use_case.dart
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/users/domain/entities/user_entity.dart';
import 'package:hometasks/src/features/users/domain/repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository userRepository;

  GetUsersUseCase({required this.userRepository});

  Future<Result<List<UserEntity>>> call() async {
    return await userRepository.getUsers();
  }
}
