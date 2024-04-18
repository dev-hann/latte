import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(
          HomeState(
            pageController: PageController(),
          ),
        ) {
    on<HomeIndexUpdated>(_onIndexUpdated);
  }

  FutureOr<void> _onIndexUpdated(
      HomeIndexUpdated event, Emitter<HomeState> emit) {
    final index = event.index;
    state.pageController.jumpToPage(index);
    emit(
      state.copyWith(
        index: index,
      ),
    );
  }
}
