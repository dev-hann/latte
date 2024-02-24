// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState({
    required this.queryController,
    this.resultList = const [],
    this.isSearching = false,
  });
  final TextEditingController queryController;
  final List<Song> resultList;
  final bool isSearching;

  @override
  List<Object> get props => [
        resultList,
        isSearching,
      ];

  SearchState copyWith({
    TextEditingController? queryController,
    List<Song>? resultList,
    bool? isSearching,
  }) {
    return SearchState(
      queryController: queryController ?? this.queryController,
      resultList: resultList ?? this.resultList,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}
