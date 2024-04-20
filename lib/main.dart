import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/view/home_view/bloc/home_bloc.dart';
import 'package:latte/view/home_view/home_view.dart';
import 'package:latte/view/play_list_view/bloc/play_list_bloc.dart';
import 'package:latte/view/search_view/bloc/search_bloc.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';

void main() async {
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
        // bottomSheetTheme: const BottomSheetThemeData(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0.0,
        // ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => MusicPlayerBloc(),
          ),
          BlocProvider(
            create: (_) => PlayListBloc(),
          ),
          BlocProvider(
            create: (_) => SearchBloc(),
          ),
          BlocProvider(
            create: (_) => HomeBloc(),
          ),
        ],
        child: const HomeView(),
      ),
    );
  }
}
