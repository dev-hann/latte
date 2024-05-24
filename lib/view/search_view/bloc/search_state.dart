// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

enum SearchStateType {
  init,
  searching,
  done,
}

class SearchState extends Equatable {
  const SearchState({
    this.type = SearchStateType.init,
    required this.queryController,
    this.isFocused = true,
    this.resultList = const [],
    this.searchSuggestionList = const [],
    this.queryDebouncer,
  });
  final SearchStateType type;
  final TextEditingController queryController;
  final bool isFocused;
  final List<Song> resultList;
  final List<SearchSuggesntion> searchSuggestionList;
  final Debouncer<String>? queryDebouncer;

  @override
  List<Object?> get props => [
        type,
        resultList,
        searchSuggestionList,
        isFocused,
        queryDebouncer,
      ];

  SearchState copyWith({
    SearchStateType? type,
    TextEditingController? queryController,
    bool? isFocused,
    List<Song>? resultList,
    List<SearchSuggesntion>? searchSuggestionList,
    Debouncer<String>? queryDebouncer,
  }) {
    return SearchState(
      type: type ?? this.type,
      queryController: queryController ?? this.queryController,
      isFocused: isFocused ?? this.isFocused,
      resultList: resultList ?? this.resultList,
      searchSuggestionList: searchSuggestionList ?? this.searchSuggestionList,
      queryDebouncer: queryDebouncer ?? this.queryDebouncer,
    );
  }
}
