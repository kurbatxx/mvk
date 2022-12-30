import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/constatnt/ui_constant.dart';
import 'package:mvk/state/playlsit/providers/basic_player_provider.dart';
import 'package:mvk/state/playlsit/providers/music_list_provider.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';
import 'package:mvk/state/playlsit/providers/player_state_provider.dart';
import 'package:mvk/views/components/slider_component.dart';

class MusicPanel extends ConsumerWidget {
  const MusicPanel({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  splashRadius: UiConstant.minimalSplashRadius,
                  onPressed: () async {
                    ref.read(basicPlayerProvder).playPreTrack();
                  },
                  icon: const Icon(
                    Icons.chevron_left,
                  ),
                ),
                const PlayPauseButton(),
                IconButton(
                  splashRadius: UiConstant.minimalSplashRadius,
                  onPressed: () {
                    ref.read(basicPlayerProvder).playNextTrack();
                  },
                  icon: const Icon(
                    Icons.chevron_right,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ref.read(playerProvider).play(
                          UrlSource(
                            ref.read(musicListProvider).first.url,
                          ),
                        );

                    ref.invalidate(playerStateProvider);
                  },
                  icon: const Icon(Icons.settings),
                )
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
          ref.read(basicPlayerProvder).play();
        },
        icon: const Icon(
          Icons.play_arrow,
        ),
      );
    }
  }
}
