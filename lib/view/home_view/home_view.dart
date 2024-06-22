import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/router/latte_router.dart';
import 'package:latte/view/dashboard_view/dashboard_view.dart';
import 'package:latte/view/home_view/bloc/home_bloc.dart';
import 'package:latte/view/play_list_view/play_list_view.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';
import 'package:latte/view/player_view/player_panel_builder.dart';
import 'package:latte/view/search_view/search_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static String get route {
    return "/";
  }

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Widget body({
    required PageController pageController,
  }) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Latte"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(LatteRouter.homeKey.currentContext!).push(
                MaterialPageRoute(
                  builder: (settings) {
                    return const SearchView();
                  },
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          Navigator(
            key: LatteRouter.dashbaordKey,
            initialRoute: DashboardView.route,
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (settings) {
                  return const DashboardView();
                },
              );
            },
          ),
          const PlayListView(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: PlayerPanelBuilder(
            body: Navigator(
              key: LatteRouter.homeKey,
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (_) {
                    return body(
                      pageController: state.pageController,
                    );
                  },
                );
              },
            ),
            bottom: BottomNavigationBar(
              currentIndex: state.bottomIndex,
              onTap: (index) {
                Navigator.popUntil(
                  LatteRouter.homeKey.currentContext!,
                  (route) {
                    return route.isFirst;
                  },
                );
                final bloc = BlocProvider.of<HomeBloc>(context);
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
