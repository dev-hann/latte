import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/view/play_list_view/bloc/play_list_bloc.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';

class PlayListView extends StatelessWidget {
  const PlayListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayListBloc, PlayListState>(
      builder: (context, state) {
        final playList = state.playList;
        final songList = playList.songList;
        final songBloc = BlocProvider.of<MusicPlayerBloc>(context);
        return ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          itemCount: songList.length,
          itemBuilder: (_, index) {
            final song = songList[index];
            return Card(
              child: ListTile(
                onTap: () {
                  songBloc.add(MusicPlayerPlayed(song));
                },
                title: Text(song.title),
                subtitle: Text(song.youtubeID),
              ),
            );
          },
        );
      },
    );
  }
}
