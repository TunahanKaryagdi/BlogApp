// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActiveUserAdapter extends TypeAdapter<ActiveUser> {
  @override
  final int typeId = 1;

  @override
  ActiveUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActiveUser(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as int,
      fields[5] as int,
      fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ActiveUser obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.surname)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.follow)
      ..writeByte(5)
      ..write(obj.follower)
      ..writeByte(6)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActiveUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
