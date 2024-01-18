// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelLocalAdapter extends TypeAdapter<UserModelLocal> {
  @override
  final int typeId = 0;

  @override
  UserModelLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModelLocal(
      id: fields[0] as String,
      email: fields[1] as String,
      displayName: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModelLocal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.displayName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
