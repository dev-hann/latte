// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

enum SearchStateType {
  init,
  searching,
  done,
}

class SearchState extends Equatable {
  const SearchState({
    required this.queryController,
    this.isFocused = true,
    this.resultList = const [],
    this.isSearching = false,
    this.searchSuggestionList = const [],
    this.queryDebouncer,
  });
  final TextEditingController queryController;
  final bool isFocused;
  final List<Song> resultList;
  final bool isSearching;
  final List<SearchSuggesntion> searchSuggestionList;
  final Debouncer<String>? queryDebouncer;

  @override
  List<Object?> get props => [
        resultList,
        isSearching,
        searchSuggestionList,
        isFocused,
        queryDebouncer,
      ];

  SearchState copyWith({
    TextEditingController? queryController,
    bool? isFocused,
    List<Song>? resultList,
    bool? isSearching,
    List<SearchSuggesntion>? searchSuggestionList,
    Debouncer<String>? queryDebouncer,
  }) {
    return SearchState(
      queryController: queryController ?? this.queryController,
      isFocused: isFocused ?? this.isFocused,
      resultList: resultList ?? this.resultList,
      isSearching: isSearching ?? this.isSearching,
      searchSuggestionList: searchSuggestionList ?? this.searchSuggestionList,
      queryDebouncer: queryDebouncer ?? this.queryDebouncer,
    );
  }
}
