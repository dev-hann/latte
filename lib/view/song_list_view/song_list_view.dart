import 'dart:async';

import 'package:flutter/material.dart';

class SongListView<T> extends StatelessWidget {
  const SongListView({
    super.key,
    required this.title,
    required this.songList,
    required this.itemBuilder,
  });
  final String title;
  final Future<List<T>> Function() songList;
  final Widget Function(T item) itemBuilder;

  static String get route {
    return "/song_list_view";
  }

  AppBar appBar({
    required String title,
  }) {
    return AppBar(
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: title,
      ),
      body: FutureBuilder<List<T>>(
        future: songList.call(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          }
          final list = snapshot.data;
          return ListView.builder(
            itemCount: list!.length,
            itemBuilder: (context, index) {
              final item = list[index];
              return itemBuilder(item);
            },
          );
        },
      ),
    );
  }
}
