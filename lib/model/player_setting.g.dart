// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerSettingAdapter extends TypeAdapter<PlayerSetting> {
  @override
  final int typeId = 4;

  @override
  PlayerSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayerSetting(
      loopMode: LoopMode.values[fields[0]],
    );
  }

  @override
  void write(BinaryWriter writer, PlayerSetting obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.loopMode.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
