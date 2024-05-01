part of 'music_player_bloc.dart';

class MusicPlayerState extends Equatable {
  const MusicPlayerState({
    this.currentSong,
    this.currentDuration,
    required this.playList,
    required this.playerState,
    required this.panelController,
    this.panelOffset = 0.0,
  });
  final Song? currentSong;
  final Duration? currentDuration;
  final PlayList playList;
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
        playList,
        playerState,
        panelController,
        panelOffset,
      ];

  MusicPlayerState copyWith({
    Song? currentSong,
    Duration? currentDuration,
    PlayList? playList,
    PlayerState? playerState,
    PanelController? panelController,
    double? panelOffset,
  }) {
    return MusicPlayerState(
      currentSong: currentSong ?? this.currentSong,
      currentDuration: currentDuration ?? this.currentDuration,
      playList: playList ?? this.playList,
      playerState: playerState ?? this.playerState,
      panelController: panelController ?? this.panelController,
      panelOffset: panelOffset ?? this.panelOffset,
    );
  }
}
