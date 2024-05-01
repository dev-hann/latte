import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/enum/page_type.dart';
import 'package:latte/model/song.dart';
import 'package:latte/view/home_view/bloc/home_bloc.dart';
import 'package:latte/view/play_list_view/bloc/play_list_bloc.dart';
import 'package:latte/view/search_view/bloc/search_bloc.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  Widget searchTextField({
    required TextEditingController controller,
    required VoidCallback onTap,
    required VoidCallback onSeachTap,
  }) {
    return TextField(
      autofocus: true,
      onTap: onTap,
      controller: controller,
      textInputAction: TextInputAction.search,
      onSubmitted: (_) {
        onSeachTap();
      },
    );
  }

  Widget searchHistoryView({
    required List<String> searchHistoryList,
    required Function(String query) onSearchTap,
  }) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        bottom: kToolbarHeight * 2,
      ),
      itemCount: searchHistoryList.length,
      itemBuilder: (_, index) {
        final query = searchHistoryList[index];
        return ListTile(
          onTap: () {
            onSearchTap(query);
          },
          leading: const Icon(Icons.history),
          title: Text(query),
        );
      },
    );
  }

  Widget searchResultView({
    required List<Song> resultList,
    required Function(Song song) onSongTap,
  }) {
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
              onSongTap(song);
            },
            title: Text(song.title),
            subtitle: Text(song.duration.toString()),
          ),
        );
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
                onTap: () {
                  searchBloc.add(SearchTextFieldFocused());
                },
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
              ],
            ),
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

                  if (state.isFocused) {
                    return searchHistoryView(
                      searchHistoryList: state.searchHistoryList,
                      onSearchTap: (query) {
                        state.queryController.text = query;
                        searchBloc.add(
                          SearchQueried(),
                        );
                      },
                    );
                  }
                  return searchResultView(
                    resultList: resultList,
                    onSongTap: (Song song) {
                      listBloc.add(PlayListSongAdded(song));
                      songBloc.add(MusicPlayerPlayed(song));
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
