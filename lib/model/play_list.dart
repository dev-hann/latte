// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:latte/model/song.dart';

class PlayList extends Equatable {
  const PlayList({
    required this.title,
    this.songList = const [],
  });
  final String title;
  final List<Song> songList;

  @override
  List<Object?> get props => [
        title,
        songList,
      ];

  PlayList copyWith({
    String? title,
    List<Song>? songList,
  }) {
    return PlayList(
      title: title ?? this.title,
      songList: songList ?? this.songList,
    );
  }
}
