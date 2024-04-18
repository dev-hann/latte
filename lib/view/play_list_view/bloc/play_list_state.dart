// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'play_list_bloc.dart';

class PlayListState extends Equatable {
  const PlayListState({
    this.playList = const PlayList(title: "Play List"),
  });
  final PlayList playList;

  @override
  List<Object> get props => [
        playList,
      ];

  PlayListState copyWith({
    PlayList? playList,
  }) {
    return PlayListState(
      playList: playList ?? this.playList,
    );
  }
}
