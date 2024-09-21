import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:latte/view/play_list_view/bloc/play_list_bloc.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';
import 'package:latte/widget/song_list_tile.dart';

class PlayListView extends StatelessWidget {
  const PlayListView({super.key});
  static String get route {
    return "/play_list_view";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayListBloc, PlayListState>(
      builder: (context, state) {
        final playListbloc = BlocProvider.of<PlayListBloc>(context);
        final playList = state.playList;
        final songList = playList.songList;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: ListView.builder(
            padding: const EdgeInsets.only(
              bottom: kTextTabBarHeight * 4,
            ),
            itemCount: songList.length,
            itemBuilder: (_, index) {
              final song = songList.reversed.toList()[index];
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
                  child: BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
                    buildWhen: (previous, current) {
                      return previous.currentSong != current.currentSong;
                    },
                    builder: (context, state) {
                      final songBloc =
                          BlocProvider.of<MusicPlayerBloc>(context);
                      final currentSong = state.currentSong;
                      final isCurrent = currentSong == song;
                      return SongListTile(
                        song: song,
                        isSelected: isCurrent,
                        onTap: () {
                          songBloc.add(
                            MusicPlayerPlayed(song),
                          );
                        },
                      );
                    },
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
