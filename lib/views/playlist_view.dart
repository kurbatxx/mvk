import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/auth/providers/auth_state_provider.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';
import 'package:mvk/views/components/playlist_widget.dart';
import 'package:mvk/views/login_view.dart';

class PlaylistView extends ConsumerWidget {
  const PlaylistView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authStateProvider);
    final credential = state.result;
    if (credential.secret.isEmpty || credential.token.isEmpty) {
      return const LoginView();
    }

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(FontAwesomeIcons.music),
        centerTitle: true,
        title: const Text('Моя музыка'),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () async {
                  ref.read(playerProvider).stop();
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
