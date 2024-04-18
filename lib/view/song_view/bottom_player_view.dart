import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:latte/util/time_format.dart';
import 'package:latte/view/song_view/bloc/song_bloc.dart';
import 'package:latte/widget/slide_text.dart';

class BottomPlayerView extends StatelessWidget {
  const BottomPlayerView({super.key});

  Widget stateButton() {
    return BlocBuilder<SongBloc, SongState>(
      buildWhen: (previous, current) {
        return previous.playerState != current.playerState;
      },
      builder: (context, state) {
        final bloc = BlocProvider.of<SongBloc>(context);
        final isPlaying = state.isPlaying;
        final isLoading = state.isLoading;

        return IconButton(
          onPressed: () {
            if (isLoading) {
              return;
            }
            if (isPlaying) {
              bloc.add(SongPaused());
            } else {
              bloc.add(const SongPlayed());
            }
          },
          icon: Builder(
            builder: (context) {
              if (isLoading) {
                return const SizedBox.square(
                  dimension: 24.0,
                  child: CircularProgressIndicator(),
                );
              }

              return Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
              );
            },
          ),
        );
      },
    );
  }

  Widget titleWidget() {
    return BlocBuilder<SongBloc, SongState>(
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
    return BlocBuilder<SongBloc, SongState>(
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      buildWhen: (previous, current) {
        return previous.playList != current.playList;
      },
      builder: (context, state) {
        final playList = state.playList;
        final songList = playList.songList;
        if (songList.isEmpty) {
          return const SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: ListTile(
              leading: stateButton(),
              title: titleWidget(),
              trailing: timeWidget(),
            ),
          ),
        );
      },
    );
  }
}
