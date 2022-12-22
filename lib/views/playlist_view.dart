import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/secure/secure_storage.dart';
import 'package:mvk/views/components/playlist_widget.dart';

class PlaylistView extends StatelessWidget {
  const PlaylistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Моя музыка'),
        actions: [
          Consumer(
            builder: (context, WidgetRef ref, Widget? child) {
              return IconButton(
                onPressed: () async {
                  await SecureStorage().delToken();
                  await SecureStorage().delSecret();
                },
                icon: const Icon(Icons.logout),
              );
            },
          )
        ],
      ),
      body: const PlaylistWidget(),
    );
  }
}
