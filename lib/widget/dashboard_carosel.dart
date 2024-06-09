import 'package:flutter/material.dart';
import 'package:latte/model/dashboard.dart';

class DashboardCarosel extends StatelessWidget {
  const DashboardCarosel({
    super.key,
    required this.title,
    required this.songList,
    required this.onSongTap,
  });
  final String title;
  final List<DashboardSong> songList;
  final Function(DashboardSong song) onSongTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final itemSize = width / 3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(
          height: itemSize,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: songList.map((song) {
              return GestureDetector(
                onTap: () {
                  onSongTap(song);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    clipBehavior: Clip.hardEdge,
                    child: SizedBox.square(
                      dimension: itemSize,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(song.imageURL),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(song.song),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
