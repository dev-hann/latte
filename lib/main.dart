import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/service/data_base.dart';
import 'package:latte/view/dashboard_view/bloc/dashboard_bloc.dart';
import 'package:latte/view/home_view/bloc/home_bloc.dart';
import 'package:latte/view/home_view/home_view.dart';
import 'package:latte/view/play_list_view/bloc/play_list_bloc.dart';
import 'package:latte/view/search_view/bloc/search_bloc.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';

void main() async {
  await DataBase.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latte',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: MultiBlocProvider(
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
        child: const HomeView(),
      ),
    );
  }
}
