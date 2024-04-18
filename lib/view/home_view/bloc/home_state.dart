part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.index = 0,
    required this.pageController,
  });
  final int index;
  final PageController pageController;

  @override
  List<Object> get props => [
        index,
        pageController,
      ];

  HomeState copyWith({
    int? index,
    PageController? pageController,
  }) {
    return HomeState(
      index: index ?? this.index,
      pageController: pageController ?? this.pageController,
    );
  }
}
