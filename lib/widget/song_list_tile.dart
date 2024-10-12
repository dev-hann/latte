import 'package:flutter/material.dart';
import 'package:latte/model/song.dart';
import 'package:latte/util/time_format.dart';
import 'package:latte/widget/slide_text.dart';

class SongListTile extends StatelessWidget {
  const SongListTile({
    super.key,
    required this.song,
    this.enable = false,
    this.isSelected = false,
    this.onTap,
  });
  final bool enable;
  final Song song;
  final bool isSelected;
  final VoidCallback? onTap;

  Widget imageWidget({
    required String imageURL,
    required Duration duration,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        return SizedBox(
          height: height,
          width: height * 1.2,
          child: Stack(
            children: [
              ShaderMask(
                blendMode: BlendMode.srcATop,
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ).createShader(bounds);
                },
                child: Image.network(imageURL),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  TimeFormat.songDuration(duration),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      onTap: onTap,
      leading: imageWidget(
        imageURL: song.thumbnail,
        duration: song.duration,
      ),
      title: Builder(
        builder: (_) {
          if (enable) {
            return SlideText(song.title);
          }
          return Text(
            song.title,
            maxLines: 1,
          );
        },
      ),
      subtitle: Text("Updated: ${TimeFormat.date(song.uploadDateTime)}"),
    );
  }
}
