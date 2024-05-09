import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/enum/page_type.dart';
import 'package:latte/view/dashboard_view/dashboard_view.dart';
import 'package:latte/view/home_view/bloc/home_bloc.dart';
import 'package:latte/view/play_list_view/play_list_view.dart';
import 'package:latte/view/player_view/player_panel_builder.dart';
import 'package:latte/view/search_view/search_view.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<HomeBloc>(context);
        final pageController = state.pageController;
        return Scaffold(
          body: PlayerPanelBuilder(
            body: Builder(
              builder: (context) {
                final pageType = state.pageType;
                switch (pageType) {
                  case PageType.search:
                    return const SearchView();
                  case PageType.dashboard:
                  case PageType.playList:
                }
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Latte"),
                    actions: [
                      IconButton(
                        onPressed: () {
                          bloc.add(
                            const HomePageTypeUpdated(PageType.search),
                          );
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ],
                  ),
                  body: PageView(
                    controller: pageController,
                    children: const [
                      DashboardView(),
                      PlayListView(),
                    ],
                  ),
                );
              },
            ),
            bottom: BottomNavigationBar(
              currentIndex: state.bottomIndex,
              onTap: (index) {
                bloc.add(HomeBottomIndexUpdated(index));
                BlocProvider.of<MusicPlayerBloc>(context)
                    .state
                    .panelController
                    .close();
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: "PlayList",
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
