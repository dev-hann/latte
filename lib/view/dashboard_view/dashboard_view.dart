import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/router/latte_router.dart';
import 'package:latte/view/dashboard_view/bloc/dashboard_bloc.dart';
import 'package:latte/view/search_view/bloc/search_bloc.dart';
import 'package:latte/view/search_view/search_view.dart';
import 'package:latte/view/song_list_view/song_list_view.dart';
import 'package:latte/widget/dashboard_carosel.dart';
import 'package:latte/widget/dasoboard_song_card.dart';
import 'package:melon/melon.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({
    super.key,
  });

  static String get route {
    return "/dashboard";
  }

  Widget songCard(MelonSong song) {
    return Builder(
      builder: (context) {
        final searchBloc = BlocProvider.of<SearchBloc>(context);
        return GestureDetector(
          onTap: () {
            searchBloc.state.queryController.text = song.query;
            searchBloc.add(
              SearchQueried(),
            );
            Navigator.of(LatteRouter.homeKey.currentContext!).push(
              MaterialPageRoute(
                builder: (settings) {
                  return const SearchView(
                    isAutoFocus: false,
                  );
                },
              ),
            );
          },
          child: DasoboardSongCard(
            imageURL: song.imageURL,
            title: song.song,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final dashboard = state.dashboard;
        if (dashboard == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          padding: const EdgeInsets.only(
            bottom: kTextTabBarHeight * 4,
          ),
          children: [
            DashboardCarosel<MelonSong>(
              title: 'TOP100',
              action: GestureDetector(
                onTap: () {
                  Navigator.of(LatteRouter.homeKey.currentContext!).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SongListView<MelonSong>(
                          title: 'TOP100',
                          songList: () async {
                            return dashboard.top100List;
                          },
                          itemBuilder: (item) {
                            return GestureDetector(
                              onTap: () {},
                              child: Card(
                                child: ListTile(
                                  title: Text(item.song),
                                  subtitle: Text(item.singer),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
                child: const Text("전체보기"),
              ),
              songList: dashboard.top100List,
              itemBuilder: (context, song) {
                return songCard(song);
              },
            ),
            DashboardCarosel(
              title: 'HOT100',
              songList: dashboard.hot100List,
              itemBuilder: (context, song) {
                return songCard(song);
              },
            ),
            DashboardCarosel(
              title: 'NEW50',
              songList: dashboard.new50List,
              itemBuilder: (context, song) {
                return songCard(song);
              },
            ),
            DashboardCarosel<MelonDj>(
              title: 'DJ',
              songList: dashboard.djList,
              itemBuilder: (context, item) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(LatteRouter.homeKey.currentContext!).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return SongListView<MelonDj>(
                            title: item.title,
                            songList: () async {
                              return <MelonDj>[];
                            },
                            itemBuilder: (item) {
                              return Text(item.toString());
                            },
                          );
                        },
                      ),
                    );
                  },
                  child: DasoboardSongCard(
                    imageURL: item.imageURL,
                    title: item.title,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
