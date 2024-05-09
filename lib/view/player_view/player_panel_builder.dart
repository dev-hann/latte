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
    required this.bottom,
  });

  final Widget body;
  final Widget bottom;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<MusicPlayerBloc>(context);
        final panelController = state.panelController;
        return Scaffold(
          body: SlidingUpPanel(
            color: Theme.of(context).cardColor,
            onPanelSlide: (value) {
              bloc.add(MusinPlayerPanelOffsetUpdatd(value));
            },
            minHeight: minHeight,
            controller: panelController,
            onPanelClosed: () {
              bloc.add(MusicPlayerStopped());
            },
            maxHeight: MediaQuery.of(context).size.height,
            collapsed: SizedBox(
              height: minHeight,
              width: MediaQuery.of(context).size.width,
              child: const MiniPlayerView(),
            ),
            panel: Opacity(
              opacity: state.panelOffset,
              child: const PlayerView(),
            ),
            body: body,
          ),
          bottomNavigationBar: Opacity(
            opacity: 1 - state.panelOffset,
            child: AnimatedContainer(
              duration: Duration.zero,
              height: (1 - state.panelOffset) * kBottomNavigationBarHeight,
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: bottom,
              ),
            ),
          ),
        );
      },
    );
  }
}
