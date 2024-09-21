import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/enum/search_suggestion_type.dart';
import 'package:latte/model/search_suggestion.dart';
import 'package:latte/model/song.dart';
import 'package:latte/view/play_list_view/bloc/play_list_bloc.dart';
import 'package:latte/view/search_view/bloc/search_bloc.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';
import 'package:latte/widget/song_list_tile.dart';

class SearchView extends StatefulWidget {
  const SearchView({
    super.key,
    this.isAutoFocus = true,
  });
  final bool isAutoFocus;
  static String get route {
    return "/search";
  }

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Widget searchTextField({
    required bool isAutoFocus,
    required TextEditingController controller,
    required VoidCallback onTap,
    required Function(String value) onchanged,
    required VoidCallback onSeachTap,
    required VoidCallback onClearTap,
  }) {
    return TextField(
      autofocus: isAutoFocus,
      onTap: onTap,
      controller: controller,
      textInputAction: TextInputAction.search,
      onSubmitted: (_) {
        onSeachTap();
      },
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: onClearTap,
          icon: const Icon(Icons.clear),
        ),
      ),
      onChanged: onchanged,
    );
  }

  Widget searchSuggestionView({
    required List<SearchSuggesntion> searchSuggestionList,
    required Function(SearchSuggesntion query) onSearchTap,
  }) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        bottom: kToolbarHeight * 4,
      ),
      itemCount: searchSuggestionList.length,
      itemBuilder: (_, index) {
        final suggestion = searchSuggestionList[index];
        return ListTile(
          onTap: () {
            onSearchTap(suggestion);
          },
          leading: suggestion.type == SearchSuggestionType.history
              ? const Icon(Icons.history)
              : const SizedBox(),
          title: Text(suggestion.query),
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
        bottom: kToolbarHeight * 4,
      ),
      itemCount: resultList.length,
      itemBuilder: (_, index) {
        final song = resultList[index];
        return Card(
          child: SongListTile(
            song: song,
            onTap: () {
              onSongTap(song);
            },
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
            primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              title: searchTextField(
                isAutoFocus: widget.isAutoFocus,
                controller: state.queryController,
                onTap: () {
                  searchBloc.add(SearchTextFieldFocused());
                },
                onSeachTap: () {
                  primaryFocus?.unfocus();
                  searchBloc.add(
                    SearchQueried(),
                  );
                },
                onClearTap: () {
                  state.queryController.clear();
                  searchBloc.add(
                    const SearchQuertyChanged(""),
                  );
                },
                onchanged: (value) {
                  searchBloc.add(
                    SearchQuertyChanged(value),
                  );
                },
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    primaryFocus?.unfocus();
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
                  switch (state.type) {
                    case SearchStateType.init:
                      return const SizedBox();
                    case SearchStateType.searching:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case SearchStateType.done:
                      if (state.isFocused) {
                        return searchSuggestionView(
                          searchSuggestionList: state.searchSuggestionList,
                          onSearchTap: (suggestion) {
                            primaryFocus?.unfocus();
                            state.queryController.text = suggestion.query;
                            searchBloc.add(
                              SearchQueried(),
                            );
                          },
                        );
                      }
                      return searchResultView(
                        resultList: resultList,
                        onSongTap: (song) {
                          primaryFocus?.unfocus();
                          listBloc.add(
                            PlayListSongAdded(song),
                          );
                          songBloc.add(
                            MusicPlayerPlayed(song),
                          );
                        },
                      );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
