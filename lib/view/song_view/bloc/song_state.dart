// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'song_bloc.dart';

class SongState extends Equatable {
  const SongState({
    this.currentsong,
    this.currentDuration,
    required this.playList,
    required this.playerState,
  });
  final Song? currentsong;
  final Duration? currentDuration;
  final PlayList playList;
  final PlayerState playerState;

  bool get isPlaying {
    return playerState.playing;
  }

  @override
  List<Object?> get props => [
        currentsong,
        currentDuration,
        playList,
        playerState,
      ];

  SongState copyWith({
    Song? currentsong,
    Duration? currentDuration,
    PlayList? playList,
    PlayerState? playerState,
  }) {
    return SongState(
      currentsong: currentsong ?? this.currentsong,
      currentDuration: currentDuration ?? this.currentDuration,
      playList: playList ?? this.playList,
      playerState: playerState ?? this.playerState,
    );
  }
}
