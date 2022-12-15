import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';

class PlayPauseTile extends ConsumerWidget {
  const PlayPauseTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audioPlayerProvider);
    final icon = player.state == PlayerState.playing
        ? const Icon(
            Icons.pause,
            color: Colors.white70,
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
