part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchInited extends SearchEvent {}

class SearchTextFieldFocused extends SearchEvent {}

class SearchQueried extends SearchEvent {}

class SearchQuertyChanged extends SearchEvent {
  const SearchQuertyChanged(this.value);
  final String value;
}

class SearchSuggestionListChanged extends SearchEvent {
  const SearchSuggestionListChanged(this.value);
  final List<SearchSuggesntion> value;
}
