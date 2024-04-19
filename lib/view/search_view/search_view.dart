import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/view/play_list_view/bloc/play_list_bloc.dart';
import 'package:latte/view/search_view/bloc/search_bloc.dart';
import 'package:latte/view/song_view/bloc/song_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  Widget searchTextField({
    required TextEditingController controller,
    required VoidCallback onSeachTap,
  }) {
    return TextField(
      controller: controller,
      onSubmitted: (_) {
        onSeachTap();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          final listBloc = BlocProvider.of<PlayListBloc>(context);
          final searchBloc = BlocProvider.of<SearchBloc>(context);
          final songBloc = BlocProvider.of<SongBloc>(context);
          final resultList = state.resultList;
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
                children: [
                  searchTextField(
                    controller: state.queryController,
                    onSeachTap: () {
                      searchBloc.add(
                        SearchQueried(),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (state.isSearching) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.only(
                            bottom: kToolbarHeight * 2,
                          ),
                          itemCount: resultList.length,
                          itemBuilder: (_, index) {
                            final song = resultList[index];
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  listBloc.add(PlayListSongAdded(song));
                                  songBloc.add(SongPlayed(song));
                                },
                                title: Text(song.title),
                                subtitle: Text(song.duration.toString()),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
