import 'package:flutter/material.dart';

class DashboardCarosel<T> extends StatelessWidget {
  const DashboardCarosel({
    super.key,
    required this.title,
    this.action,
    required this.songList,
    required this.itemBuilder,
    this.height,
  });
  final String title;
  final Widget? action;
  final List<T> songList;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              action ?? const SizedBox(),
            ],
          ),
        ),
        SizedBox(
          height: height ?? MediaQuery.of(context).size.width / 3,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            scrollDirection: Axis.horizontal,
            children: songList.map((song) {
              return itemBuilder(context, song);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
