// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryDataAdapter extends TypeAdapter<CategoryData> {
  @override
  final int typeId = 1;

  @override
  CategoryData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryData(
      id: fields[0] as String,
      name: fields[1] as String,
      iconData: fields[2] as int,
      color: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.iconData)
      ..writeByte(3)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
