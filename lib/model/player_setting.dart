import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:latte/enum/loop_mode.dart';

part 'player_setting.g.dart';

@HiveType(typeId: 4)
class PlayerSetting extends Equatable {
  const PlayerSetting({
    this.loopMode = LatteLoopMode.off,
  });
  @HiveField(0)
  final LatteLoopMode loopMode;

  @override
  List<Object?> get props => [
        loopMode,
      ];

  PlayerSetting copyWith({
    LatteLoopMode? loopMode,
  }) {
    return PlayerSetting(
      loopMode: loopMode ?? this.loopMode,
    );
  }
}
