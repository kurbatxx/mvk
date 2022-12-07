import 'package:flutter/material.dart';

class PlaylistView extends StatelessWidget {
  const PlaylistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: const Center(child: Text('App')),
    );
  }
}
