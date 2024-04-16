import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:latte/view/home_view.dart';
import 'package:latte/view/play_list_view/bloc/play_list_bloc.dart';
import 'package:latte/view/search_view/bloc/search_bloc.dart';
import 'package:latte/view/song_view/bloc/song_bloc.dart';

void main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.hann.latte.audio',
    androidNotificationChannelName: 'audio channel',
    androidNotificationOngoing: true,
  );
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
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SongBloc(),
          ),
          BlocProvider(
            create: (_) => PlayListBloc(),
          ),
          BlocProvider(
            create: (_) => SearchBloc(),
          ),
        ],
        child: const HomeView(),
      ),
    );
  }
}
