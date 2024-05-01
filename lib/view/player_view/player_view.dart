import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/util/time_format.dart';
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
        dimension: 180.0,
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
    required Duration? songDuration,
  }) {
    return Column(
      children: [
        MusicProgressWidget(
          currentDuration: currentDuration,
          songDuration: songDuration,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(TimeFormat.songDuration(currentDuration)),
            Text(TimeFormat.songDuration(songDuration)),
          ],
        ),
      ],
    );
  }

  Widget controlButtonsWidget() {
    return const SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.shuffle,
          ),
          Icon(
            Icons.skip_previous,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: PlayButton(
                size: 40.0,
              ),
            ),
          ),
          Icon(
            Icons.skip_next,
          ),
          Icon(
            Icons.loop,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context, state) {
        final currentSong = state.currentSong;
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
                      currentDuration: state.currentDuration,
                      songDuration: currentSong.duration,
                    ),
                    const SizedBox(height: 24.0),
                    controlButtonsWidget(),
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
