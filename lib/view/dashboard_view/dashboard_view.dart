import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/enum/page_type.dart';
import 'package:latte/view/dashboard_view/bloc/dashboard_bloc.dart';
import 'package:latte/view/home_view/bloc/home_bloc.dart';
import 'package:latte/view/search_view/bloc/search_bloc.dart';
import 'package:latte/widget/dashboard_carosel.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final searchBloc = BlocProvider.of<SearchBloc>(context);
        final homeBloc = BlocProvider.of<HomeBloc>(context);

        final dashboard = state.dashboard;
        if (dashboard == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: ListView(
            padding: EdgeInsets.only(bottom: kTextTabBarHeight * 4),
            children: [
              DashboardCarosel(
                title: 'TOP100',
                songList: dashboard.top100List,
                onSongTap: (song) {
                  searchBloc.state.queryController.text = song.query;
                  searchBloc.add(
                    SearchQueried(),
                  );
                  homeBloc.add(
                    const HomePageTypeUpdated(PageType.search),
                  );
                },
              ),
              DashboardCarosel(
                title: 'HOT100',
                songList: dashboard.hot100List,
                onSongTap: (song) {
                  searchBloc.state.queryController.text = song.query;
                  searchBloc.add(
                    SearchQueried(),
                  );
                  homeBloc.add(
                    const HomePageTypeUpdated(PageType.search),
                  );
                },
              ),
              DashboardCarosel(
                title: 'NEW50',
                songList: dashboard.new50List,
                onSongTap: (song) {
                  searchBloc.state.queryController.text = song.query;
                  searchBloc.add(
                    SearchQueried(),
                  );
                  homeBloc.add(
                    const HomePageTypeUpdated(PageType.search),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
