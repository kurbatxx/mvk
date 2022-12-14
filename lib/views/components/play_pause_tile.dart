import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/player_state_stream_provider.dart';

class PlayPauseTile extends ConsumerWidget {
  const PlayPauseTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerStateStreamProvider);
    final icon = playerState.value == PlayerState.playing
        ? const Icon(
            Icons.pause,
          )
        : const Icon(Icons.play_arrow);

    return CircleAvatar(
      backgroundColor: Colors.amber,
      child: Center(
        child: icon,
      ),
    );
  }
}
