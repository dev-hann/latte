import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Latte"),
      ),
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}
