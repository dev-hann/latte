// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loop_mode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LatteLoopModeAdapter extends TypeAdapter<LatteLoopMode> {
  @override
  final int typeId = 91;

  @override
  LatteLoopMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LatteLoopMode.off;
      case 1:
        return LatteLoopMode.one;
      case 2:
        return LatteLoopMode.all;
      default:
        return LatteLoopMode.off;
    }
  }

  @override
  void write(BinaryWriter writer, LatteLoopMode obj) {
    switch (obj) {
      case LatteLoopMode.off:
        writer.writeByte(0);
        break;
      case LatteLoopMode.one:
        writer.writeByte(1);
        break;
      case LatteLoopMode.all:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LatteLoopModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
