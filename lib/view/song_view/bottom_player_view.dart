import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/util/time_format.dart';
import 'package:latte/view/song_view/bloc/song_bloc.dart';

class BottomPlayerView extends StatelessWidget {
  const BottomPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        final playList = state.playList;
        final songList = playList.songList;
        final currentSong = state.currentsong;
        if (songList.isEmpty || currentSong == null) {
          return const SizedBox();
        }
        final bloc = BlocProvider.of<SongBloc>(context);
        final isPlaying = state.isPlaying;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: ListTile(
              leading: IconButton(
                onPressed: () {
                  if (isPlaying) {
                    bloc.add(SongPaused());
                  } else {
                    bloc.add(const SongPlayed());
                  }
                },
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
              title: Text(
                currentSong.title,
                maxLines: 1,
              ),
              trailing: Text(
                "${TimeFormat.songDuration(state.currentDuration)}/${TimeFormat.songDuration(currentSong.duration)}",
              ),
            ),
          ),
        );
      },
    );
  }
}
