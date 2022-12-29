import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';
import 'package:mvk/state/playlsit/providers/player_state_provider.dart';
import 'package:mvk/state/playlsit/providers/playlist_provider.dart';
import 'package:mvk/state/playlsit/providers/source_provider.dart';
import 'package:mvk/views/components/slider_component.dart';

class MusicPanel extends ConsumerWidget {
  const MusicPanel({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.read(playerProvider);

    return SizedBox(
      height: 80,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black54,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chevron_left,
                  ),
                ),
                const PlayPauseButton(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chevron_right,
                  ),
                ),
              ],
            ),
            const SliderWidget(),
          ],
        ),
      ),
    );
  }
}

class PlayPauseButton extends ConsumerWidget {
  const PlayPauseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerStateProvider);

    if (playerState == PlayerState.playing) {
      return IconButton(
        onPressed: () {
          final source = ref.read(sourceProvider);
        },
        icon: const Icon(
          Icons.pause,
        ),
      );
    } else {
      return IconButton(
        onPressed: () {
          final source = ref.read(sourceProvider);
          if (source.isEmpty) {}
        },
        icon: const Icon(
          Icons.play_arrow,
        ),
      );
    }
  }
}
