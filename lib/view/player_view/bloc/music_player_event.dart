part of 'music_player_bloc.dart';

abstract class MusicPlayerEvent extends Equatable {
  const MusicPlayerEvent();

  @override
  List<Object> get props => [];
}

class MusicPlayerInited extends MusicPlayerEvent {}

class MusicPlayerSongListUpdated extends MusicPlayerEvent {
  const MusicPlayerSongListUpdated(this.playList);
  final PlayList playList;
  @override
  List<Object> get props => [playList];
}

class MusicPlayerPlayed extends MusicPlayerEvent {
  const MusicPlayerPlayed([this.song]);
  final Song? song;
}

class MusicPlayerPaused extends MusicPlayerEvent {}

class MusicPlayerStopped extends MusicPlayerEvent {}

class MusicPlayerSeeked extends MusicPlayerEvent {
  const MusicPlayerSeeked(this.position);
  final Duration position;
}

class MusinPlayerPanelOffsetUpdatd extends MusicPlayerEvent {
  const MusinPlayerPanelOffsetUpdatd(this.panelOffset);
  final double panelOffset;
}

class MusicPlayerSettingInited extends MusicPlayerEvent {}

class MusicPlayerSettingUpdated extends MusicPlayerEvent {
  const MusicPlayerSettingUpdated(this.setting);
  final PlayerSetting setting;
}
