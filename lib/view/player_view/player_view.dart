import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({
    super.key,
  });

  Widget thumbnailWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: const ColoredBox(
        color: Colors.blue,
        child: SizedBox.square(
          dimension: 100.0,
        ),
      ),
    );
  }

  Widget titleWidget() {
    return const Text("TestTitle");
  }

  Widget descWidget() {
    return const Text("TestDesc");
  }

  Widget progressWidget() {
    return const Column(
      children: [
        LinearProgressIndicator(
          value: 0.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("00::00"),
            Text("12::34"),
          ],
        ),
      ],
    );
  }

  Widget controlButtonsWidget() {
    return const SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.shuffle,
          ),
          Icon(
            Icons.skip_previous,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.play_arrow,
                size: 40.0,
              ),
            ),
          ),
          Icon(
            Icons.skip_next,
          ),
          Icon(
            Icons.loop,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            thumbnailWidget(),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerLeft,
              child: titleWidget(),
            ),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerLeft,
              child: descWidget(),
            ),
            const SizedBox(height: 24.0),
            progressWidget(),
            const SizedBox(height: 24.0),
            controlButtonsWidget(),
          ],
        ),
      ),
    );
  }
}
