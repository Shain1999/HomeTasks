// domain/usecases/stream_users_use_case.dart

import 'dart:async';
import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class StreamUsersUseCase {
  final AuthRepository authRepository;

  StreamUsersUseCase({required this.authRepository});

  Stream<List<AuthUser?>> handle()  {
    try {
      return authRepository.getUsers();
    } catch (error) {
      // Handle the error as needed
      throw Exception(error);
    }
  }
}
