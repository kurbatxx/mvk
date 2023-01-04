import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/constatnt/ui_constant.dart';
import 'package:mvk/state/playlsit/providers/basic_player_provider.dart';
import 'package:mvk/state/playlsit/providers/player_state_provider.dart';
import 'package:mvk/state/playlsit/providers/source_provider.dart';
import 'package:mvk/views/components/slider_component.dart';

class MusicPanel extends ConsumerWidget {
  const MusicPanel({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 80,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      splashColor: Colors.white,
                      onPressed: () {
                        ref.read(basicPlayerProvder).playNextTrack();
                      },
                      icon: const Icon(
                        Icons.chevron_right,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -(UiConstant.sliderHeight / 2),
          width: MediaQuery.of(context).size.width,
          child: const SliderWidget(),
        ),
      ],
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
