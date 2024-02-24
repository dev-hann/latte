import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latte/model/song.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc()
      : super(
          SearchState(
            queryController: TextEditingController(),
          ),
        ) {
    on<SearchQueried>(_onFind);
  }
  final yt = YoutubeExplode();

  FutureOr<void> _onFind(SearchQueried event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        isSearching: true,
      ),
    );
    final searchList = await yt.search.search(
      state.queryController.text,
    );
    final songList = searchList.map((item) {
      return Song(
        title: item.title,
        youtubeID: item.id.value,
        duration: item.duration,
      );
    }).toList();
    emit(
      state.copyWith(
        isSearching: false,
        resultList: songList,
      ),
    );
  }
}
