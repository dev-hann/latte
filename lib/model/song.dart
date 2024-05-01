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
  });

  @HiveField(0)
  final String title;
  @HiveField(1)
  final String youtubeID;
  @HiveField(2)
  final Duration duration;

  Future<String?> get audioURL async {
    final manifest =
        await YoutubeExplode().videos.streamsClient.getManifest(youtubeID);
    final list = manifest.audioOnly;
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
      ];
  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "youtubeID": youtubeID,
      "duration": duration.inMilliseconds,
    };
  }

  factory Song.fromMap(dynamic data) {
    final map = Map<String, dynamic>.from(data);
    return Song(
      title: map["title"],
      youtubeID: map["youtubeID"],
      duration: Duration(milliseconds: map["duration"]),
    );
  }
}
