// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';

part 'player_setting.g.dart';

@HiveType(typeId: 4)
class PlayerSetting extends Equatable {
  const PlayerSetting({
    this.loopMode = LoopMode.off,
  });
  @HiveField(0)
  final LoopMode loopMode;

  @override
  List<Object?> get props => [
        loopMode,
      ];

  PlayerSetting copyWith({
    LoopMode? loopMode,
  }) {
    return PlayerSetting(
      loopMode: loopMode ?? this.loopMode,
    );
  }
}
