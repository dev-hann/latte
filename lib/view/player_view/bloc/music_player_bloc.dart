import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:latte/model/play_list.dart';
import 'package:latte/model/player_setting.dart';
import 'package:latte/model/song.dart';
import 'package:latte/service/audio_service.dart';
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
    on<MusicPlayerSettingInited>(_onSettingInited);
    on<MusicPlayerPlayed>(_onPlayed);
    on<MusicPlayerPaused>(_onPaused);
    on<MusicPlayerSeeked>(_onSeeked);
    on<MusicPlayerStopped>(_onStopped);
    on<MusinPlayerPanelOffsetUpdatd>(_onPenelOffsetUpdated);
    on<MusicPlayerSettingUpdated>(_onSettingUpdated);
  }
  final service = AudioService();

  FutureOr<void> _onInited(
      MusicPlayerInited event, Emitter<MusicPlayerState> emit) async {
    await service.init();
    add(MusicPlayerSettingInited());
    final audioStream =
        Rx.combineLatest3<PlayerState, Duration, Duration, MusicPlayerState>(
      service.playerStateStream,
      service.positionStream,
      service.bufferedPostionStream,
      (playerState, position, bufferedPosiotion) {
        return state.copyWith(
          playerState: playerState,
          currentDuration: position,
          bufferedDuration: bufferedPosiotion,
        );
      },
    );
    state.panelController.hide();

    return emit.forEach(
      audioStream,
      onData: (newState) {
        return newState;
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
        service.play();
      }
      return;
    }
    if (songList.isEmpty) {
      await state.panelController.show();
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
    final isOK = await service.setAudio(song);
    if (isOK) {
      emit(
        state.copyWith(
          currentSong: song,
        ),
      );
      service.play();
    }
  }

  FutureOr<void> _onStopped(
      MusicPlayerStopped event, Emitter<MusicPlayerState> emit) {
    service.stop();
  }

  FutureOr<void> _onPaused(
      MusicPlayerPaused event, Emitter<MusicPlayerState> emit) {
    service.pause();
  }

  FutureOr<void> _onPenelOffsetUpdated(
      MusinPlayerPanelOffsetUpdatd event, Emitter<MusicPlayerState> emit) {
    emit(
      state.copyWith(
        panelOffset: event.panelOffset,
      ),
    );
  }

  FutureOr<void> _onSettingInited(
      MusicPlayerSettingInited event, Emitter<MusicPlayerState> emit) {
    final setting = service.loadSetting();
    emit(
      state.copyWith(
        setting: setting,
      ),
    );

    return emit.onEach(
      service.playerSettingStream,
      onData: (setting) {
        emit(
          state.copyWith(
            setting: setting,
          ),
        );
      },
    );
  }

  FutureOr<void> _onSettingUpdated(
      MusicPlayerSettingUpdated event, Emitter<MusicPlayerState> emit) {
    return service.updateSetting(event.setting);
  }

  FutureOr<void> _onSeeked(
      MusicPlayerSeeked event, Emitter<MusicPlayerState> emit) {
    return service.seek(event.position);
  }
}
