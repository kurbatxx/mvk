import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/auth/providers/auth_state_provider.dart';
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
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () async {
                  ref.read(authStateProvider.notifier).logout();
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
