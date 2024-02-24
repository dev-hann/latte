import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latte/model/play_list.dart';

part 'play_list_event.dart';
part 'play_list_state.dart';

class PlayListBloc extends Bloc<PlayListEvent, PlayListState> {
  PlayListBloc() : super(const PlayListState()) {
    on<PlayListIndexUpdated>(_onIndexUpdated);
  }

  FutureOr<void> _onIndexUpdated(
      PlayListIndexUpdated event, Emitter<PlayListState> emit) {
    emit(
      state.copyWith(
        currentIndex: event.index,
      ),
    );
  }
}
