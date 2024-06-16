import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/router/latte_router.dart';
import 'package:latte/view/home_view/bloc/home_bloc.dart';
import 'package:latte/view/page_view/latte_page_view.dart';
import 'package:latte/view/player_view/player_panel_builder.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static String get route {
    return "/";
  }

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
            body: Navigator(
              key: LatteRouter.homeKey,
              initialRoute: LattePageView.route,
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (_) {
                    return LattePageView(
                      controller: pageController,
                    );
                  },
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
