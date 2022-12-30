import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/music_len_provider.dart';
import 'package:mvk/state/playlsit/providers/music_position_provider.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';

class SliderWidget extends HookConsumerWidget {
  const SliderWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackLen = ref.watch(musicLenProvider);
    final musicPosition = ref.watch(musicPositionProvider);

    final position = musicPosition.asData?.value ?? const Duration();
    final currentPosition = position.inSeconds.toDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackShape: const RoundedRectSliderTrackShape(),
          trackHeight: 10,
          thumbColor: Colors.blue,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
          overlayShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0),
        ),
        child: Slider(
          max: trackLen,
          value: currentPosition,
          onChanged: (double value) async {
            await ref.read(playerProvider).seek(
                  Duration(
                    seconds: value.toInt(),
                  ),
                );
          },
        ),
      ),
    );
  }
}
