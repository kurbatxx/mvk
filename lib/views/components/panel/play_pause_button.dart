import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/constatnt/ui_constant.dart';
import 'package:mvk/state/playlsit/providers/basic_player_provider.dart';
import 'package:mvk/state/playlsit/providers/player_state_stream_provider.dart';
import 'package:mvk/state/playlsit/providers/source_provider.dart';

class PlayPauseButton extends ConsumerWidget {
  const PlayPauseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerStateStreamProvider);

    if (playerState.value == PlayerState.playing) {
      return IconButton(
        splashRadius: UiConstant.basicSplashRadius,
        onPressed: () {
          ref.read(basicPlayerProvder).pause();
        },
        icon: const Icon(
          Icons.pause,
        ),
      );
    } else {
      return IconButton(
        splashRadius: UiConstant.basicSplashRadius,
        onPressed: () {
          ref.read(basicPlayerProvder).playOrPause(
                url: ref.read(sourceProvider),
              );
        },
        icon: const Icon(
          Icons.play_arrow,
        ),
      );
    }
  }
}
