import 'package:flutter/material.dart';
import 'package:latte/router/latte_router.dart';
import 'package:latte/view/dashboard_view/dashboard_view.dart';
import 'package:latte/view/play_list_view/play_list_view.dart';
import 'package:latte/view/search_view/search_view.dart';

class LattePageView extends StatelessWidget {
  const LattePageView({
    super.key,
    required this.controller,
  });

  static String get route {
    return "/latte_pate_view";
  }

  final PageController controller;

  @override
  Widget build(BuildContext context) {
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
        controller: controller,
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
}
