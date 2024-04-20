import 'package:flutter/material.dart';

class MusicProgressWidget extends StatelessWidget {
  const MusicProgressWidget({
    super.key,
    required this.currentDuration,
    required this.songDuration,
  });

  final Duration? currentDuration;
  final Duration? songDuration;

  @override
  Widget build(BuildContext context) {
    final currentValue = (currentDuration?.inMilliseconds ?? 0.0);
    final songValue = (songDuration?.inMilliseconds ?? 1.0);
    final value = currentValue / songValue;
    return LinearProgressIndicator(
      value: value,
    );
  }
}
