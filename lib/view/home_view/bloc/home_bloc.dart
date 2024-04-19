import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latte/enum/page_type.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(
          HomeState(
            pageController: PageController(),
          ),
        ) {
    on<HomePageTypeUpdated>(_onPageTypeUpdated);
    on<HomeBottomIndexUpdated>(_onBottomIndexUpdated);
  }

  FutureOr<void> _onPageTypeUpdated(
      HomePageTypeUpdated event, Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        pageType: event.pageType,
      ),
    );
  }

  FutureOr<void> _onBottomIndexUpdated(
      HomeBottomIndexUpdated event, Emitter<HomeState> emit) {
    final index = event.index;
    final pageType = PageType.values[index];
    emit(
      state.copyWith(
        pageType: pageType,
        bottomIndex: index,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state.pageController.jumpToPage(index);
    });
  }
}
