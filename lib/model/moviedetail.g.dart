// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moviedetail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoviedetailAdapter extends TypeAdapter<Moviedetail> {
  @override
  final int typeId = 0;

  @override
  Moviedetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Moviedetail()
      ..name = fields[0] as String
      ..director = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, Moviedetail obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.director);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoviedetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
