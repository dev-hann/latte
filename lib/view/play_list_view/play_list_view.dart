import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/view/play_list_view/bloc/play_list_bloc.dart';

class PlayListView extends StatelessWidget {
  const PlayListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayListBloc, PlayListState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<PlayListBloc>(context);
        final list = state.list;
        return DefaultTabController(
          length: list.length,
          child: Column(
            children: [
              TabBar(
                onTap: (index) {
                  bloc.add(
                    PlayListIndexUpdated(index),
                  );
                },
                tabs: list.map((playList) {
                  return Text(playList.title);
                }).toList(),
              ),
              TabBarView(
                children: list.map((playList) {
                  final songList = playList.songList;
                  return ListView.builder(
                    itemCount: songList.length,
                    itemBuilder: (_, index) {
                      final song = songList[index];
                      return ListTile(
                        title: Text(song.title),
                        subtitle: Text(song.youtubeID),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
