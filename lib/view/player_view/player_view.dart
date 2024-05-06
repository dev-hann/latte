import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';
import 'package:latte/widget/music_progress_widget.dart';
import 'package:latte/widget/play_button.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({
    super.key,
  });

  Widget thumbnailWidget({
    required String imageURL,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: SizedBox.square(
        dimension: 240.0,
        child: Image.network(
          imageURL,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget titleWidget({
    required String title,
  }) {
    return Text(title);
  }

  Widget descWidget({
    required String desc,
  }) {
    return Text(desc);
  }

  Widget progressWidget({
    required Duration? currentDuration,
    required Duration? bufferedDucation,
    required Duration? songDuration,
    required Function(Duration position) onSeek,
  }) {
    return MusicProgressWidget(
      currentDuration: currentDuration,
      buffredDuration: bufferedDucation,
      songDuration: songDuration,
      onSeek: onSeek,
    );
  }

  Widget controlButtonWidget({
    required VoidCallback onTap,
    required Widget child,
  }) {
    return IconButton(
      onPressed: onTap,
      icon: child,
    );
  }

  Widget controlButtonsWidget({
    required LoopMode loopMode,
    required Function(LoopMode value) onLoopModeChaned,
    required VoidCallback onFastForwardTap,
    required VoidCallback onFastRewindTap,
  }) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(
            Icons.shuffle,
          ),
          controlButtonWidget(
            onTap: onFastRewindTap,
            child: const Icon(
              Icons.fast_rewind,
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: PlayButton(
                size: 40.0,
              ),
            ),
          ),
          controlButtonWidget(
            onTap: onFastForwardTap,
            child: const Icon(
              Icons.fast_forward,
            ),
          ),
          loopModeWidget(
            loopMode: loopMode,
            onLoopModeChaned: onLoopModeChaned,
          ),
        ],
      ),
    );
  }

  Widget loopModeWidget({
    required LoopMode loopMode,
    required Function(LoopMode value) onLoopModeChaned,
  }) {
    return GestureDetector(
      onTap: () {
        LoopMode nextMode;
        switch (loopMode) {
          case LoopMode.off:
            nextMode = LoopMode.all;
            break;
          case LoopMode.one:
            nextMode = LoopMode.off;
            break;
          case LoopMode.all:
            nextMode = LoopMode.one;
            break;
        }
        onLoopModeChaned(nextMode);
      },
      child: Builder(
        builder: (context) {
          switch (loopMode) {
            case LoopMode.off:
              return const Icon(
                Icons.repeat,
              );
            case LoopMode.one:
              return const Icon(
                Icons.repeat_one,
              );
            case LoopMode.all:
              return const Icon(
                Icons.repeat_on,
              );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<MusicPlayerBloc>(context);

        final setting = state.setting;
        final loopMode = state.setting.loopMode;
        final currentSong = state.currentSong;
        final currentDuration = state.currentDuration;
        if (currentSong == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: 0.5,
              image: NetworkImage(
                currentSong.thumbnail,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    thumbnailWidget(
                      imageURL: currentSong.thumbnail,
                    ),
                    const SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: titleWidget(
                        title: currentSong.title,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    progressWidget(
                      currentDuration: currentDuration,
                      bufferedDucation: state.bufferedDuration,
                      songDuration: currentSong.duration,
                      onSeek: (position) {
                        bloc.add(
                          MusicPlayerSeeked(position),
                        );
                      },
                    ),
                    const SizedBox(height: 24.0),
                    controlButtonsWidget(
                      loopMode: loopMode,
                      onLoopModeChaned: (value) {
                        bloc.add(
                          MusicPlayerSettingUpdated(
                            setting.copyWith(
                              loopMode: value,
                            ),
                          ),
                        );
                      },
                      onFastForwardTap: () {
                        if (currentDuration != null) {
                          final position =
                              currentDuration + const Duration(seconds: 15);
                          bloc.add(
                            MusicPlayerSeeked(position),
                          );
                        }
                      },
                      onFastRewindTap: () {
                        if (currentDuration != null) {
                          final position =
                              currentDuration - const Duration(seconds: 15);
                          bloc.add(
                            MusicPlayerSeeked(position),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
