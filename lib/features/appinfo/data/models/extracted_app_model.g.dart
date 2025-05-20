// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extracted_app_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExtractedAppModelAdapter extends TypeAdapter<ExtractedAppModel> {
  @override
  final int typeId = 1;

  @override
  ExtractedAppModel read(final BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExtractedAppModel(
      appIcon: fields[0] as Uint8List,
      appName: fields[1] as String,
      packageName: fields[2] as String,
      appSize: fields[3] as String,
      appPath: fields[4] as String,
    );
  }

  @override
  void write(final BinaryWriter writer, final ExtractedAppModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.appIcon)
      ..writeByte(1)
      ..write(obj.appName)
      ..writeByte(2)
      ..write(obj.packageName)
      ..writeByte(3)
      ..write(obj.appSize)
      ..writeByte(4)
      ..write(obj.appPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is ExtractedAppModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
