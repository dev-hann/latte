import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latte/model/play_list.dart';
import 'package:latte/model/song.dart';
import 'package:latte/service/play_list_service.dart';

part 'play_list_event.dart';
part 'play_list_state.dart';

class PlayListBloc extends Bloc<PlayListEvent, PlayListState> {
  PlayListBloc() : super(const PlayListState()) {
    on<PlayListInited>(_onInited);
    on<PlayListIndexUpdated>(_onIndexUpdated);
    on<PlayListSongAdded>(_onSongAdded);
    on<PlayListSongRemoved>(_onSongRemoved);
  }
  final service = PlayListService();
  FutureOr<void> _onInited(
      PlayListInited event, Emitter<PlayListState> emit) async {
    await service.init();
    final playList = service.loadPlayList();
    emit(
      state.copyWith(
        playList: playList,
      ),
    );
    return emit.onEach(
      service.stream,
      onData: (newPlayList) {
        if (newPlayList != null) {
          emit(
            state.copyWith(
              playList: newPlayList,
            ),
          );
        }
      },
    );
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
    }
    service.updatePlayList(
      playList.copyWith(songList: list),
    );
  }

  FutureOr<void> _onSongRemoved(
      PlayListSongRemoved event, Emitter<PlayListState> emit) {
    final song = event.song;
    final playList = state.playList;
    final list = [...playList.songList];
    list.remove(song);
    service.updatePlayList(
      playList.copyWith(songList: list),
    );
  }
}
