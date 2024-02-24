import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/view/search_view/search_view.dart';
import 'package:latte/view/song_view/bloc/song_bloc.dart';
import 'package:latte/view/song_view/bottom_player_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SongBloc>(context, listen: false).add(SongInited());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Latte"),
      ),
      body: const SearchView(),
      bottomNavigationBar: const BottomPlayerView(),
    );
  }
}
