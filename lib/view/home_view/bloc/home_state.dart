part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.pageType = PageType.dashboard,
    this.bottomIndex = 0,
    required this.pageController,
  });
  final PageType pageType;
  final int bottomIndex;
  final PageController pageController;

  @override
  List<Object> get props => [
        pageType,
        bottomIndex,
        pageController,
      ];

  HomeState copyWith({
    PageType? pageType,
    int? bottomIndex,
    PageController? pageController,
  }) {
    return HomeState(
      pageType: pageType ?? this.pageType,
      bottomIndex: bottomIndex ?? this.bottomIndex,
      pageController: pageController ?? this.pageController,
    );
  }
}
