import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latte/model/play_list.dart';
import 'package:latte/model/song.dart';

part 'play_list_event.dart';
part 'play_list_state.dart';

class PlayListBloc extends Bloc<PlayListEvent, PlayListState> {
  PlayListBloc() : super(const PlayListState()) {
    on<PlayListIndexUpdated>(_onIndexUpdated);
    on<PlayListSongAdded>(_onSongAdded);
  }

  FutureOr<void> _onIndexUpdated(
      PlayListIndexUpdated event, Emitter<PlayListState> emit) {}

  FutureOr<void> _onSongAdded(
      PlayListSongAdded event, Emitter<PlayListState> emit) {
    final song = event.song;
    final playList = state.playList;

    final list = [...playList.songList];
    if (!list.contains(song)) {
      list.add(event.song);
      emit(
        state.copyWith(
          playList: playList.copyWith(
            songList: list,
          ),
        ),
      );
    }
  }
}
