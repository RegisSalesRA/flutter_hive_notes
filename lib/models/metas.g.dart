// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metas.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MetasAdapter extends TypeAdapter<Metas> {
  @override
  final int typeId = 2;

  @override
  Metas read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Metas(
      id: fields[0] as int?,
      title: fields[1] as String,
      description: fields[2] as String,
      done: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Metas obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.done);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetasAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
