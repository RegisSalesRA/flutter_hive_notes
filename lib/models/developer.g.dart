// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeveloperAdapter extends TypeAdapter<Developer> {
  @override
  final int typeId = 0;

  @override
  Developer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Developer(
      name: fields[1] as String,
      isGraduated: fields[3] as bool,
      choices: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Developer obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.choices)
      ..writeByte(3)
      ..write(obj.isGraduated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeveloperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
