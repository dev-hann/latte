import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:latte/model/song.dart';

part 'play_list.g.dart';

@HiveType(typeId: 2)
class PlayList extends Equatable {
  const PlayList({
    required this.title,
    this.songList = const [],
  });
  @HiveField(0)
  final String title;
  @HiveField(1)
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

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      "songList": songList.map((song) {
        return song.toMap();
      }),
    };
  }

  factory PlayList.fromMap(Map<String, dynamic> data) {
    final map = Map<String, dynamic>.from(data);
    return PlayList(
      title: map["title"],
      songList: List.from(map["songList"]).map((songData) {
        return Song.fromMap(songData);
      }).toList(),
    );
  }
}
