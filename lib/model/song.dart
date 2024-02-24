import 'package:equatable/equatable.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Song extends Equatable {
  const Song({
    required this.title,
    required this.youtubeID,
    this.duration,
  });

  final String title;
  final String youtubeID;
  final Duration? duration;

  Future<String?> get audioURL async {
    final manifest =
        await YoutubeExplode().videos.streamsClient.getManifest(youtubeID);
    final list = manifest.audioOnly;
    if (list.isEmpty) {
      return null;
    }
    return list.first.url.toString();
  }

  @override
  List<Object?> get props => [
        title,
        youtubeID,
        duration,
      ];
}
