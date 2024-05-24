import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/enum/page_type.dart';
import 'package:latte/enum/search_suggestion_type.dart';
import 'package:latte/model/search_suggestion.dart';
import 'package:latte/model/song.dart';
import 'package:latte/view/home_view/bloc/home_bloc.dart';
import 'package:latte/view/play_list_view/bloc/play_list_bloc.dart';
import 'package:latte/view/search_view/bloc/search_bloc.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  void initState() {
    super.initState();
  }

  Widget searchTextField({
    required TextEditingController controller,
    required VoidCallback onTap,
    required Function(String value) onchanged,
    required VoidCallback onSeachTap,
    required VoidCallback onClearTap,
  }) {
    return TextField(
      autofocus: true,
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
        bottom: kToolbarHeight * 2,
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
                  FocusManager.instance.primaryFocus?.unfocus();
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
                    FocusManager.instance.primaryFocus?.unfocus();
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
                            state.queryController.text = suggestion.query;
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
