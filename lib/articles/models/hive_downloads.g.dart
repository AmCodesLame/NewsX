// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_downloads.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadedAdapter extends TypeAdapter<Downloaded> {
  @override
  final int typeId = 0;

  @override
  Downloaded read(BinaryReader reader) {
    return Downloaded();
  }

  @override
  void write(BinaryWriter writer, Downloaded obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
