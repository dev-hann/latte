import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:latte/util/time_format.dart';
import 'package:latte/view/play_list_view/bloc/play_list_bloc.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';

class PlayListView extends StatelessWidget {
  const PlayListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayListBloc, PlayListState>(
      builder: (context, state) {
        final playListbloc = BlocProvider.of<PlayListBloc>(context);
        final playList = state.playList;
        final songList = playList.songList;
        final songBloc = BlocProvider.of<MusicPlayerBloc>(context);
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: ListView.builder(
            padding: const EdgeInsets.only(
              bottom: kToolbarHeight * 1.5,
            ),
            itemCount: songList.length,
            itemBuilder: (_, index) {
              final song = songList.toList()[index];
              return Card(
                clipBehavior: Clip.hardEdge,
                child: Slidable(
                  key: ValueKey(song),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(
                      onDismissed: () {
                        playListbloc.add(PlayListSongRemoved(song));
                      },
                    ),
                    children: [
                      SlidableAction(
                        autoClose: false,
                        onPressed: (context) async {
                          final controller = Slidable.of(context);
                          controller?.dismiss(
                            ResizeRequest(
                              const Duration(milliseconds: 300),
                              () {
                                playListbloc.add(PlayListSongRemoved(song));
                              },
                            ),
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () async {
                      final index = playList.songList.indexWhere((e) {
                        return e == song;
                      });
                      if (index != -1) {
                        songBloc.add(
                          MusicPlayerSongListUpdated(
                            playList,
                            inintIndex: index,
                          ),
                        );
                      }

                      // songBloc.add(
                      //   MusicPlayerPlayed(song),
                      // );
                    },
                    title: Text(song.title),
                    subtitle: Text(
                      TimeFormat.songDuration(song.duration),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
