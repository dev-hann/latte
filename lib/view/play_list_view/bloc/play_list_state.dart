// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'play_list_bloc.dart';

class PlayListState extends Equatable {
  const PlayListState({
    this.list = const [],
    this.currentIndex = 0,
  });
  final List<PlayList> list;
  final int currentIndex;

  @override
  List<Object> get props => [
        list,
        currentIndex,
      ];

  PlayListState copyWith({
    List<PlayList>? list,
    int? currentIndex,
  }) {
    return PlayListState(
      list: list ?? this.list,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
