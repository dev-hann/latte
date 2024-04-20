import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latte/view/player_view/bloc/music_player_bloc.dart';
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
    return const ColoredBox(
      color: Colors.red,
      child: SizedBox(
        height: minHeight,
        child: Center(
          child: Text("BottomPlayer"),
        ),
      ),
    );
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
          onPanelSlide: (value) {
            bloc.add(MusinPlayerPanelOffsetUpdatd(value));
          },
          minHeight: kToolbarHeight * 1.2,
          controller: panelController,
          maxHeight: MediaQuery.of(context).size.height,
          panel: GestureDetector(
            onTap: () {
              panelController.open();
            },
            child: Stack(
              children: [
                Opacity(
                  opacity: 1 - state.panelOffset,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: bottomPlayerWidget(),
                  ),
                ),
                Opacity(
                  opacity: state.panelOffset,
                  child: playerWidget(),
                ),
              ],
            ),
          ),
          body: body,
        );
      },
    );
  }
}
