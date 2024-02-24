part of 'song_bloc.dart';

abstract class SongEvent extends Equatable {
  const SongEvent();

  @override
  List<Object> get props => [];
}

class SongInited extends SongEvent {}

class SongPlayed extends SongEvent {
  const SongPlayed([this.song]);
  final Song? song;
}

class SongPaused extends SongEvent {}

class SongStopped extends SongEvent {}
