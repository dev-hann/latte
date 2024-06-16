import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:latte/view/dashboard_view/bloc/dashboard_bloc.dart';
import 'package:latte/view/dashboard_view/dashboard_view.dart';
import 'package:latte/view/home_view/bloc/home_bloc.dart';
import 'package:latte/view/home_view/home_view.dart';
import 'package:latte/view/play_list_view/bloc/play_list_bloc.dart';
import 'package:latte/view/play_list_view/play_list_view.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';
import 'package:latte/view/search_view/bloc/search_bloc.dart';
import 'package:latte/view/search_view/search_view.dart';

// class LatteRouter {
//   LatteRouter._();
//   static LatteRouter? _instance;

//   static LatteRouter get instance {
//     return _instance ??= LatteRouter._();
//   }

//   final homeKey = GlobalKey<NavigatorState>();
// }

class LatteRouter {
  static final homeKey = GlobalKey<NavigatorState>();
  static final dashbaordKey = GlobalKey<NavigatorState>();
  static final _router = GoRouter(
    navigatorKey: homeKey,
    initialLocation: HomeView.route,
    routes: [
      GoRoute(
        path: HomeView.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) {
                  final bloc = MusicPlayerBloc();
                  bloc.add(MusicPlayerInited());
                  return bloc;
                },
              ),
              BlocProvider(
                create: (_) {
                  final bloc = PlayListBloc();
                  bloc.add(PlayListInited());
                  return bloc;
                },
              ),
              BlocProvider(
                lazy: false,
                create: (_) {
                  final bloc = SearchBloc();
                  bloc.add(SearchInited());
                  return bloc;
                },
              ),
              BlocProvider(
                create: (_) => HomeBloc(),
              ),
              BlocProvider(
                create: (_) {
                  final bloc = DashboardBloc();
                  bloc.add(DashboardInited());
                  return bloc;
                },
              ),
            ],
            child: Builder(
              builder: (context) {
                return const HomeView();
              },
            ),
          );
        },
      ),
      // ShellRoute(
      //   navigatorKey: _shellNavigatorKey,
      //   builder: (context, state, child) {
      //     return MultiBlocProvider(
      //       providers: [
      //         BlocProvider(
      //           create: (_) {
      //             final bloc = MusicPlayerBloc();
      //             bloc.add(MusicPlayerInited());
      //             return bloc;
      //           },
      //         ),
      //         BlocProvider(
      //           create: (_) {
      //             final bloc = PlayListBloc();
      //             bloc.add(PlayListInited());
      //             return bloc;
      //           },
      //         ),
      //         BlocProvider(
      //           lazy: false,
      //           create: (_) {
      //             final bloc = SearchBloc();
      //             bloc.add(SearchInited());
      //             return bloc;
      //           },
      //         ),
      //         BlocProvider(
      //           create: (_) => HomeBloc(),
      //         ),
      //         BlocProvider(
      //           create: (_) {
      //             final bloc = DashboardBloc();
      //             bloc.add(DashboardInited());
      //             return bloc;
      //           },
      //         ),
      //       ],
      //       child: Builder(
      //         builder: (context) {
      //           if (state.path == SearchView.route) {
      //             return child;
      //           }
      //           return const HomeView();
      //         },
      //       ),
      //     );
      //   },
      //   routes: [
      //     GoRoute(
      //       path: DashboardView.route,
      //       pageBuilder: (context, state) {
      //         return const NoTransitionPage(
      //           child: DashboardView(),
      //         );
      //       },
      //     ),
      //     GoRoute(
      //       path: PlayListView.route,
      //       pageBuilder: (context, state) {
      //         return const NoTransitionPage(
      //           child: PlayListView(),
      //         );
      //       },
      //     ),
      //     GoRoute(
      //       path: SearchView.route,
      //       pageBuilder: (context, state) {
      //         return const NoTransitionPage(
      //           child: SearchView(),
      //         );
      //       },
      //     ),
      //   ],
      // ),
    ],
    // errorBuilder: (context, state) => const NotFoundScreen(),
  );

  static GoRouter get router => _router;
}
