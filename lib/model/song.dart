import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

part 'song.g.dart';

@HiveType(typeId: 1)
class Song extends Equatable {
  const Song({
    required this.title,
    required this.youtubeID,
    required this.duration,
    required this.author,
    required this.uploadDateTime,
  });

  @HiveField(0)
  final String title;
  @HiveField(1)
  final String youtubeID;
  @HiveField(2)
  final Duration duration;
  @HiveField(3)
  final String author;
  @HiveField(4)
  final DateTime? uploadDateTime;

  Future<String?> get audioURL async {
    final manifest =
        await YoutubeExplode().videos.streamsClient.getManifest(youtubeID);
    final list = manifest.audio;
    if (list.isEmpty) {
      return null;
    }
    return list.first.url.toString();
  }

  String get thumbnail {
    return "https://img.youtube.com/vi/$youtubeID/hqdefault.jpg";
  }

  @override
  List<Object?> get props => [
        title,
        youtubeID,
        duration,
        author,
        uploadDateTime,
      ];
  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "youtubeID": youtubeID,
      "duration": duration.inMilliseconds,
      "author": author,
      "uploadDateTime": uploadDateTime?.millisecondsSinceEpoch,
    };
  }

  factory Song.fromMap(dynamic data) {
    final map = Map<String, dynamic>.from(data);
    return Song(
      title: map["title"],
      youtubeID: map["youtubeID"],
      duration: Duration(milliseconds: map["duration"]),
      author: map["author"],
      uploadDateTime: map["uploadDatetime"] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map["uploadDatetime"]),
    );
  }
}
