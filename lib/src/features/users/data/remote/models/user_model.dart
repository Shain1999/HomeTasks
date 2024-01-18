import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/users/domain/entities/user_entity.dart';


class UserModel extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? photoURL;

  const UserModel({
    required this.id,
    required this.email,
    this.name,
    this.photoURL,
  });

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      photoURL: entity.photoURL,
    );
  }
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      id: snap['id']??'',
      email: snap['email']?? '',
      name: snap['name']??'',
      photoURL: snap['photoURL']??''
    );
  }
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      photoURL: photoURL,
    );
  }

  @override
  List<Object?> get props => [id, email, name, photoURL];
}
