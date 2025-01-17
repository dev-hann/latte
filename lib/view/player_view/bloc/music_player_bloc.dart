import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:latte/model/media_item.dart';
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
    on<MusicPlayerSongListUpdated>(_onSongListUpdated);
  }
  final service = AudioService();

  FutureOr<void> _onInited(
      MusicPlayerInited event, Emitter<MusicPlayerState> emit) async {
    await service.init();
    add(MusicPlayerSettingInited());
    final audioStream = Rx.combineLatest4<PlayerState, Duration, Duration,
        SequenceState?, MusicPlayerState>(
      service.playerStateStream,
      service.positionStream,
      service.bufferedPostionStream,
      service.sequenceStateStream,
      (playerState, position, bufferedPosiotion, sequenceState) {
        return state.copyWith(
          playerState: playerState,
          currentDuration: position,
          bufferedDuration: bufferedPosiotion,
          sequenceState: sequenceState,
        );
      },
    );
    final panelController = state.panelController;
    await panelController.hide();

    return emit.forEach(
      audioStream,
      onData: (newState) {
        return newState;
      },
    );
  }

  FutureOr<void> _onPlayed(
      MusicPlayerPlayed event, Emitter<MusicPlayerState> emit) async {
    final song = event.song;
    if (state.currentSong == song) {
      return;
    }
    final panelController = state.panelController;
    if (!panelController.isPanelShown) {
      await panelController.show();
    }
    final songList = state.songList;
    int index = songList.indexWhere((e) {
      return e == song;
    });
    if (index == -1) {
      index = await service.setAudio(song);
    }
    await service.seek(Duration.zero, index: index);
    await service.play();
    await service.setLoopMode(state.sequenceState?.loopMode ?? LoopMode.off);
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

  FutureOr<void> _onSongListUpdated(
      MusicPlayerSongListUpdated event, Emitter<MusicPlayerState> emit) async {
    final panelController = state.panelController;
    if (!panelController.isPanelShown) {
      await panelController.show();
    }
    final list = event.playList;
    await service.setAudioList(
      list.songList,
    );
  }
}
