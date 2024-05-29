import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
    required this.size,
  });
  final double size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      buildWhen: (previous, current) {
        return previous.playerState != current.playerState;
      },
      builder: (context, state) {
        final bloc = BlocProvider.of<MusicPlayerBloc>(context);
        final isPlaying = state.isPlaying;
        final isLoading = state.isLoading;

        return IconButton(
          onPressed: () {
            if (isLoading) {
              return;
            }
            if (isPlaying) {
              bloc.add(MusicPlayerPaused());
            } else {
              bloc.add(MusicPlayerPlayed(bloc.state.currentSong!));
            }
          },
          icon: Builder(
            builder: (context) {
              if (isLoading) {
                return SizedBox.square(
                  dimension: size,
                  child: const CircularProgressIndicator(),
                );
              }

              return Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: size,
              );
            },
          ),
        );
      },
    );
  }
}
