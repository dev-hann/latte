import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:latte/model/play_list.dart';
import 'package:latte/model/song.dart';
import 'package:rxdart/rxdart.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  SongBloc()
      : super(
          SongState(
            playList: const PlayList(
              title: 'Default List',
            ),
            playerState: PlayerState(false, ProcessingState.idle),
          ),
        ) {
    on<SongInited>(_onInited);
    on<SongPlayed>(_onPlayed);
    on<SongPaused>(_onPaused);
    on<SongStopped>(_onStopped);
  }

  final audio = AudioPlayer();
  FutureOr<void> _onInited(SongInited event, Emitter<SongState> emit) async {
    final stream = Rx.combineLatest2<PlayerState, Duration, SongState>(
      audio.playerStateStream,
      audio.positionStream,
      (playerState, position) {
        return state.copyWith(
          playerState: playerState,
          currentDuration: position,
        );
      },
    );
    await emit.forEach(
      stream,
      onData: (newstate) {
        return newstate;
      },
    );
  }

  FutureOr<void> _onPlayed(SongPlayed event, Emitter<SongState> emit) async {
    final playList = state.playList;
    final songList = playList.songList;
    final song = event.song;
    if (song == null) {
      if (state.playerState.processingState == ProcessingState.ready) {
        audio.play();
      }
      return;
    }

    if (!songList.contains(song)) {
      final newSongList = [...songList, song];
      emit(
        state.copyWith(
          playList: playList.copyWith(
            songList: newSongList,
          ),
        ),
      );
    }
    final audioURL = await song.audioURL;
    if (audioURL != null) {
      emit(
        state.copyWith(
          currentsong: song,
        ),
      );
      final source = AudioSource.uri(
        Uri.parse(audioURL),
        tag: MediaItem(
          id: song.youtubeID,
          title: song.title,
          artUri: Uri.parse(song.thumbnail),
        ),
      );
      await audio.setAudioSource(source);
      audio.play();
    }
  }

  FutureOr<void> _onStopped(SongStopped event, Emitter<SongState> emit) {
    if (audio.playing) {
      audio.stop();
    }
  }

  FutureOr<void> _onPaused(SongPaused event, Emitter<SongState> emit) {
    if (audio.playing) {
      audio.pause();
    }
  }
}
