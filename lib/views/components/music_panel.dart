import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/music_len_provider.dart';
import 'package:mvk/state/playlsit/providers/music_position_provider.dart';

class MusicPanel extends HookConsumerWidget {
  const MusicPanel({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicPosition = ref.watch(musicPositionProvider);
    final position = musicPosition.asData?.value ?? const Duration();
    final currentPosition = position.inSeconds.toDouble();

    return SizedBox(
      height: 100,
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
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.play_arrow,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chevron_right,
                  ),
                ),
              ],
            ),
            Slider(
              max: ref.watch(musicLenProvider),
              value: currentPosition,
              onChanged: (double value) {},
            ),
          ],
        ),
      ),
    );
  }
}
