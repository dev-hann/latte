import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';
import 'package:latte/view/player_view/mini_player_view.dart';
import 'package:latte/view/player_view/player_view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

const minHeight = kToolbarHeight * 1.2;

class PlayerPanelBuilder extends StatelessWidget {
  const PlayerPanelBuilder({
    super.key,
    required this.body,
  });

  final Widget body;

  Widget bottomPlayerWidget() {
    return const MiniPlayerView();
  }

  Widget playerWidget() {
    return const PlayerView();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<MusicPlayerBloc>(context);
        final panelController = state.panelController;
        return SlidingUpPanel(
          color: Theme.of(context).cardColor,
          onPanelSlide: (value) {
            bloc.add(MusinPlayerPanelOffsetUpdatd(value));
          },
          minHeight: minHeight,
          controller: panelController,
          maxHeight: MediaQuery.of(context).size.height,
          panel: Stack(
            children: [
              Opacity(
                opacity: state.panelOffset,
                child: playerWidget(),
              ),
              Opacity(
                opacity: 1 - state.panelOffset,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: bottomPlayerWidget(),
                ),
              ),
            ],
          ),
          body: body,
        );
      },
    );
  }
}
