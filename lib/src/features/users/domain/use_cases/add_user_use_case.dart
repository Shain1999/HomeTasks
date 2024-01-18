// domain/usecases/add_user_use_case.dart
import 'package:hometasks/src/core/results/result.dart';
import 'package:hometasks/src/features/users/domain/entities/user_entity.dart';
import 'package:hometasks/src/features/users/domain/repositories/user_repository.dart';

class AddUserUseCase {
  final UserRepository userRepository;

  AddUserUseCase({required this.userRepository});

  Future<Result> call(UserEntity user) async {
    return await userRepository.addUser(user);
  }
}
