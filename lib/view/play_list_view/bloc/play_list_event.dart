part of 'play_list_bloc.dart';

abstract class PlayListEvent extends Equatable {
  const PlayListEvent();

  @override
  List<Object> get props => [];
}

class PlayListInited extends PlayListEvent {}

class PlayListIndexUpdated extends PlayListEvent {
  const PlayListIndexUpdated(this.index);
  final int index;
}

class PlayListSongAdded extends PlayListEvent {
  const PlayListSongAdded(this.song);
  final Song song;
}

class PlayListSongRemoved extends PlayListEvent {
  const PlayListSongRemoved(this.song);
  final Song song;
}
