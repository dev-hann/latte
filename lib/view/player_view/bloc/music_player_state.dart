part of 'music_player_bloc.dart';

class MusicPlayerState extends Equatable {
  const MusicPlayerState({
    this.currentSong,
    this.currentDuration,
    this.bufferedDuration,
    this.setting = const PlayerSetting(),
    required this.playList,
    required this.playerState,
    required this.panelController,
    this.panelOffset = 0.0,
  });
  final Song? currentSong;
  final Duration? currentDuration;
  final Duration? bufferedDuration;
  final PlayList playList;
  final PlayerSetting setting;
  final PlayerState playerState;
  final PanelController panelController;
  final double panelOffset;

  bool get isPlaying {
    return playerState.playing;
  }

  bool get isLoading {
    switch (playerState.processingState) {
      case ProcessingState.idle:
      case ProcessingState.loading:
      case ProcessingState.buffering:
        return true;
      case ProcessingState.ready:
      case ProcessingState.completed:
        return false;
    }
  }

  @override
  List<Object?> get props => [
        currentSong,
        currentDuration,
        bufferedDuration,
        playList,
        playerState,
        panelController,
        panelOffset,
        setting,
      ];

  MusicPlayerState copyWith({
    Song? currentSong,
    Duration? currentDuration,
    Duration? bufferedDuration,
    PlayList? playList,
    PlayerState? playerState,
    PanelController? panelController,
    double? panelOffset,
    PlayerSetting? setting,
  }) {
    return MusicPlayerState(
      currentSong: currentSong ?? this.currentSong,
      currentDuration: currentDuration ?? this.currentDuration,
      bufferedDuration: bufferedDuration ?? this.bufferedDuration,
      playList: playList ?? this.playList,
      playerState: playerState ?? this.playerState,
      panelController: panelController ?? this.panelController,
      panelOffset: panelOffset ?? this.panelOffset,
      setting: setting ?? this.setting,
    );
  }
}
