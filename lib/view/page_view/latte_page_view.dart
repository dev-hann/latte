import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/view/dashboard_view/dashboard_view.dart';
import 'package:latte/view/home_view/bloc/home_bloc.dart';
import 'package:latte/view/play_list_view/play_list_view.dart';
import 'package:latte/view/search_view/search_view.dart';

class LattePageView extends StatelessWidget {
  const LattePageView({
    super.key,
  });

  static String get route {
    return "/latte_pate_view";
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    final pageController = bloc.state.pageController;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Latte"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
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
        children: const [
          // Navigator(
          //   key: LatteRouter.dashbaordKey,
          //   initialRoute: DashboardView.route,
          //   onGenerateRoute: (settings) {
          //     return MaterialPageRoute(
          //       builder: (settings) {
          //         return const DashboardView();
          //       },
          //     );
          //   },
          // ),
          DashboardView(),
          PlayListView(),
        ],
      ),
    );
  }
}
