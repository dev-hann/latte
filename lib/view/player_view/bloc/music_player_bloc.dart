import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:latte/model/play_list.dart';
import 'package:latte/model/song.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'music_player_event.dart';
part 'music_player_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  MusicPlayerBloc()
      : super(
          MusicPlayerState(
            playList: const PlayList(
              title: 'Default List',
            ),
            playerState: PlayerState(false, ProcessingState.idle),
            panelController: PanelController(),
          ),
        ) {
    on<MusicPlayerInited>(_onInited);
    on<MusicPlayerPlayed>(_onPlayed);
    on<MusicPlayerPaused>(_onPaused);
    on<MusicPlayerStopped>(_onStopped);
    on<MusinPlayerPanelOffsetUpdatd>(_onPenelOffsetUpdated);
  }

  final audio = AudioPlayer();
  FutureOr<void> _onInited(
      MusicPlayerInited event, Emitter<MusicPlayerState> emit) async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.hann.latte.audio',
      androidNotificationChannelName: 'audio channel',
      androidNotificationOngoing: true,
    );
    final stream = Rx.combineLatest2<PlayerState, Duration, MusicPlayerState>(
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

  FutureOr<void> _onPlayed(
      MusicPlayerPlayed event, Emitter<MusicPlayerState> emit) async {
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
      await audio.setAudioSource(
        source,
        preload: false,
      );
      if (!state.isPlaying) {
        audio.play();
      }
    }
  }

  FutureOr<void> _onStopped(
      MusicPlayerStopped event, Emitter<MusicPlayerState> emit) {
    if (audio.playing) {
      audio.stop();
    }
  }

  FutureOr<void> _onPaused(
      MusicPlayerPaused event, Emitter<MusicPlayerState> emit) {
    if (audio.playing) {
      audio.pause();
    }
  }

  FutureOr<void> _onPenelOffsetUpdated(
      MusinPlayerPanelOffsetUpdatd event, Emitter<MusicPlayerState> emit) {
    emit(
      state.copyWith(
        panelOffset: event.panelOffset,
      ),
    );
  }
}
