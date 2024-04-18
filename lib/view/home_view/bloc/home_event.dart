part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeIndexUpdated extends HomeEvent {
  const HomeIndexUpdated(this.index);
  final int index;
}
