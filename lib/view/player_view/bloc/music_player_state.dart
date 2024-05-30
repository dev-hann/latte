part of 'music_player_bloc.dart';

class MusicPlayerState extends Equatable {
  const MusicPlayerState({
    this.currentDuration,
    this.bufferedDuration,
    this.setting = const PlayerSetting(),
    required this.playerState,
    required this.panelController,
    this.panelOffset = 0.0,
    this.sequenceState,
  });
  final Duration? currentDuration;
  final Duration? bufferedDuration;
  final PlayerSetting setting;
  final PlayerState playerState;
  final PanelController panelController;
  final double panelOffset;
  final SequenceState? sequenceState;

  List<Song> get songList {
    if (sequenceState == null) {
      return [];
    }
    return sequenceState!.sequence.map((e) {
      final tag = e.tag as MediaItem;
      return Song(
        title: tag.title,
        youtubeID: tag.id,
        duration: tag.duration!,
      );
    }).toList();
  }

  Song? get currentSong {
    final currentSequence = sequenceState?.currentSource;
    if (currentSequence == null) {
      return null;
    }
    final tag = currentSequence.tag as MediaItem;
    return Song(
      title: tag.title,
      youtubeID: tag.id,
      duration: tag.duration!,
    );
  }

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
        playerState,
        panelController,
        panelOffset,
        setting,
      ];

  MusicPlayerState copyWith({
    Duration? currentDuration,
    Duration? bufferedDuration,
    PlayerState? playerState,
    PanelController? panelController,
    double? panelOffset,
    PlayerSetting? setting,
    SequenceState? sequenceState,
  }) {
    return MusicPlayerState(
      currentDuration: currentDuration ?? this.currentDuration,
      bufferedDuration: bufferedDuration ?? this.bufferedDuration,
      playerState: playerState ?? this.playerState,
      panelController: panelController ?? this.panelController,
      panelOffset: panelOffset ?? this.panelOffset,
      setting: setting ?? this.setting,
      sequenceState: sequenceState ?? this.sequenceState,
    );
  }
}
