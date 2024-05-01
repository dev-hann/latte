// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState({
    required this.queryController,
    this.isFocused = true,
    this.resultList = const [],
    this.isSearching = false,
    this.searchHistoryList = const [],
  });
  final TextEditingController queryController;
  final bool isFocused;
  final List<Song> resultList;
  final bool isSearching;
  final List<String> searchHistoryList;

  @override
  List<Object> get props => [
        resultList,
        isSearching,
        searchHistoryList,
        isFocused,
      ];

  SearchState copyWith({
    TextEditingController? queryController,
    bool? isFocused,
    List<Song>? resultList,
    bool? isSearching,
    List<String>? searchHistoryList,
  }) {
    return SearchState(
      queryController: queryController ?? this.queryController,
      isFocused: isFocused ?? this.isFocused,
      resultList: resultList ?? this.resultList,
      isSearching: isSearching ?? this.isSearching,
      searchHistoryList: searchHistoryList ?? this.searchHistoryList,
    );
  }
}
