// user_local_model.dart
import 'package:hive/hive.dart';

part 'user_local_model.g.dart';

@HiveType(typeId: 0)
class UserModelLocal {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String photoURL;

  UserModelLocal({
    required this.id,
    required this.email,
    required this.name,
    required this.photoURL,
  });
}