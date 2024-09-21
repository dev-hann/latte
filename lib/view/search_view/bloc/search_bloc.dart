import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latte/enum/search_suggestion_type.dart';
import 'package:latte/model/search_suggestion.dart';
import 'package:latte/model/song.dart';
import 'package:latte/service/search_service.dart';
import 'package:latte/util/debouncer.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc()
      : super(
          SearchState(
            queryController: TextEditingController(),
          ),
        ) {
    on<SearchInited>(_onInited);
    on<SearchTextFieldFocused>(_onTextFieldFocused);
    on<SearchQueried>(_onQuery);
    on<SearchQuertyChanged>(_onQueryChanged);
    on<SearchSuggestionListChanged>(_onSuggestionListUpdated);
  }
  final service = SearchService();

  FutureOr<void> _onInited(
      SearchInited event, Emitter<SearchState> emit) async {
    await service.init();
    emit(
      state.copyWith(
        type: SearchStateType.done,
        searchSuggestionList: service.loadSearchHistoryList(),
      ),
    );
    return emit.onEach(
      service.stream,
      onData: (searchedList) {
        emit(
          state.copyWith(
            searchSuggestionList: searchedList,
          ),
        );
      },
    );
  }

  FutureOr<void> _onQuery(
      SearchQueried event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        type: SearchStateType.searching,
      ),
    );
    final query = state.queryController.text;
    final searchHistoryList = [...service.loadSearchHistoryList()];
    if (!searchHistoryList.map((e) => e.query).contains(query)) {
      searchHistoryList.insert(
        0,
        SearchSuggesntion(
          type: SearchSuggestionType.history,
          query: query,
        ),
      );
      service.updateSearchHistoryList(searchHistoryList);
    }

    final searchList = await service.search(query);
    final songList = searchList.map((item) {
      return Song(
        title: item.title,
        youtubeID: item.id.value,
        duration: item.duration ?? Duration.zero,
        author: item.author,
        uploadDateTime: item.uploadDate,
      );
    }).toList();
    emit(
      state.copyWith(
        type: SearchStateType.done,
        resultList: songList,
        isFocused: false,
      ),
    );
  }

  FutureOr<void> _onTextFieldFocused(
      SearchTextFieldFocused event, Emitter<SearchState> emit) {
    emit(
      state.copyWith(isFocused: true),
    );
  }

  FutureOr<void> _onQueryChanged(
      SearchQuertyChanged event, Emitter<SearchState> emit) async {
    final query = event.value;
    if (query.isEmpty) {
      final list = service.loadSearchHistoryList();
      add(
        SearchSuggestionListChanged(list),
      );
      return;
    }
    final debouncer = state.queryDebouncer ??
        Debouncer<String>(
          duration: const Duration(milliseconds: 500),
          onValue: (value) async {
            if (value != null) {
              final list = await service.searchSuggestionList(value);
              add(
                SearchSuggestionListChanged(list),
              );
            }
          },
        );

    debouncer.value = event.value;
    if (state.queryDebouncer == null) {
      emit(
        state.copyWith(
          queryDebouncer: debouncer,
        ),
      );
    }
  }

  FutureOr<void> _onSuggestionListUpdated(
      SearchSuggestionListChanged event, Emitter<SearchState> emit) {
    emit(
      state.copyWith(
        searchSuggestionList: event.value,
        isFocused: true,
      ),
    );
  }
}
