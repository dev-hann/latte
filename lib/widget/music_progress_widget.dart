import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

class MusicProgressWidget extends StatelessWidget {
  const MusicProgressWidget({
    super.key,
    required this.currentDuration,
    required this.buffredDuration,
    required this.songDuration,
    this.onSeek,
    this.showTimeLabel = true,
    this.showThumb = true,
  });

  final Duration? currentDuration;
  final Duration? buffredDuration;
  final Duration? songDuration;
  final bool showTimeLabel;
  final bool showThumb;
  final Function(Duration position)? onSeek;

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      progress: currentDuration ?? Duration.zero,
      buffered: buffredDuration,
      total: songDuration ?? Duration.zero,
      thumbRadius: showThumb ? 8.0 : 0.0,
      timeLabelLocation:
          showTimeLabel ? TimeLabelLocation.below : TimeLabelLocation.none,
      onSeek: onSeek,
    );
  }
}
