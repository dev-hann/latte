import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/util/time_format.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';
import 'package:latte/widget/music_progress_widget.dart';
import 'package:latte/widget/play_button.dart';
import 'package:latte/widget/slide_text.dart';

class MiniPlayerView extends StatelessWidget {
  const MiniPlayerView({
    super.key,
  });

  Widget thumbnailWidget() {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      buildWhen: (previous, current) {
        return previous.currentsong?.thumbnail !=
            current.currentsong?.thumbnail;
      },
      builder: (context, state) {
        final currentSong = state.currentsong;
        if (currentSong == null) {
          return const SizedBox();
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: SizedBox.square(
            dimension: 40.0,
            child: Image.network(
              currentSong.thumbnail,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  Widget titleWidget() {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      buildWhen: (previous, current) {
        return previous.currentsong?.title != current.currentsong?.title;
      },
      builder: (context, state) {
        final currentSong = state.currentsong;
        return SlideText(
          currentSong?.title ?? "",
        );
      },
    );
  }

  Widget timeWidget() {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context, state) {
        final currentSong = state.currentsong;
        if (currentSong == null) {
          return const SizedBox();
        }
        return Text(
          "${TimeFormat.songDuration(state.currentDuration)}/${TimeFormat.songDuration(currentSong.duration)}",
        );
      },
    );
  }

  Widget progressWidget() {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context, state) {
        return MusicProgressWidget(
          currentDuration: state.currentDuration,
          songDuration: state.currentsong?.duration,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      buildWhen: (previous, current) {
        return previous.playList != current.playList;
      },
      builder: (context, state) {
        final playList = state.playList;
        final songList = playList.songList;
        final panelController = state.panelController;
        if (songList.isEmpty) {
          return const SizedBox();
        }
        return Column(
          children: [
            ListTile(
              onTap: () {
                panelController.open();
              },
              leading: thumbnailWidget(),
              title: titleWidget(),
              trailing: const PlayButton(
                size: 24.0,
              ),
            ),
            progressWidget(),
          ],
        );
      },
    );
  }
}
