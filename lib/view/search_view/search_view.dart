import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/enum/page_type.dart';
import 'package:latte/view/home_view/bloc/home_bloc.dart';
import 'package:latte/view/play_list_view/bloc/play_list_bloc.dart';
import 'package:latte/view/search_view/bloc/search_bloc.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  Widget searchTextField({
    required TextEditingController controller,
    required VoidCallback onSeachTap,
  }) {
    return TextField(
      autofocus: true,
      controller: controller,
      textInputAction: TextInputAction.search,
      onSubmitted: (_) {
        onSeachTap();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final listBloc = BlocProvider.of<PlayListBloc>(context);
        final searchBloc = BlocProvider.of<SearchBloc>(context);
        final songBloc = BlocProvider.of<MusicPlayerBloc>(context);
        final resultList = state.resultList;
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    final bloc = BlocProvider.of<HomeBloc>(context);
                    bloc.add(
                      const HomePageTypeUpdated(PageType.playList),
                    );
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                title: searchTextField(
                  controller: state.queryController,
                  onSeachTap: () {
                    searchBloc.add(
                      SearchQueried(),
                    );
                  },
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      searchBloc.add(
                        SearchQueried(),
                      );
                    },
                    icon: const Icon(Icons.search),
                  )
                ]),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
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
                            songBloc.add(MusicPlayerPlayed(song));
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
          ),
        );
      },
    );
  }
}
