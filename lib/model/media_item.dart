import 'package:just_audio_background/just_audio_background.dart';

class LatteMediaItem extends MediaItem {
  LatteMediaItem({
    required super.id,
    required super.title,
    required super.artUri,
    required super.duration,
    required this.author,
    required this.uploadDateTime,
  });

  final String author;
  final DateTime? uploadDateTime;
}
