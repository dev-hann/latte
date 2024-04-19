part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeBottomIndexUpdated extends HomeEvent {
  const HomeBottomIndexUpdated(this.index);
  final int index;
}

class HomePageTypeUpdated extends HomeEvent {
  const HomePageTypeUpdated(this.pageType);
  final PageType pageType;
}
