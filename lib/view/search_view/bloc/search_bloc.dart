import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latte/model/song.dart';
import 'package:latte/service/search_service.dart';

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
  }
  final service = SearchService();

  FutureOr<void> _onInited(
      SearchInited event, Emitter<SearchState> emit) async {
    await service.init();
    final historyList = service.loadSearchedList();
    emit(
      state.copyWith(
        searchHistoryList: historyList,
      ),
    );
    return emit.onEach(
      service.stream,
      onData: (searchedList) {
        emit(
          state.copyWith(
            searchHistoryList: searchedList,
          ),
        );
      },
    );
  }

  FutureOr<void> _onQuery(
      SearchQueried event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        isSearching: true,
      ),
    );
    final query = state.queryController.text;
    final searchList = await service.search(query);
    final searchHistoryList = [...state.searchHistoryList];
    if (!searchHistoryList.contains(query)) {
      searchHistoryList.insert(0, query);
      service.updateSearchHistoryList(searchHistoryList);
    }

    final songList = searchList.map((item) {
      return Song(
        title: item.title,
        youtubeID: item.id.value,
        duration: item.duration ?? Duration.zero,
      );
    }).toList();
    emit(
      state.copyWith(
        isSearching: false,
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
}
