import 'package:flutter/material.dart';

class SongListView extends StatelessWidget {
  const SongListView({
    super.key,
  });
  static String get route {
    return "/song_list_view";
  }

  AppBar appBar() {
    return AppBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: const Center(
        child: Text("!!!"),
      ),
    );
  }
}
