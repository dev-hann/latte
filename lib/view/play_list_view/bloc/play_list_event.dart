part of 'play_list_bloc.dart';

abstract class PlayListEvent extends Equatable {
  const PlayListEvent();

  @override
  List<Object> get props => [];
}

class PlayListIndexUpdated extends PlayListEvent {
  const PlayListIndexUpdated(this.index);
  final int index;
}
