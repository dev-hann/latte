import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/enum/page_type.dart';
import 'package:latte/view/dashboard_view/bloc/dashboard_bloc.dart';
import 'package:latte/view/home_view/bloc/home_bloc.dart';
import 'package:latte/view/search_view/bloc/search_bloc.dart';
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
        final homeBloc = BlocProvider.of<HomeBloc>(context);
        return GestureDetector(
          onTap: () {
            searchBloc.state.queryController.text = song.query;
            searchBloc.add(
              SearchQueried(),
            );
            homeBloc.add(
              const HomePageTypeUpdated(PageType.search),
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
        // final searchBloc = BlocProvider.of<SearchBloc>(context);
        // final homeBloc = BlocProvider.of<HomeBloc>(context);

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
              action: const Text("전체보기"),
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
            DashboardCarosel(
              title: 'DJ',
              songList: dashboard.djList,
              itemBuilder: (context, item) {
                return DasoboardSongCard(
                  imageURL: item.imageURL,
                  title: item.title,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
