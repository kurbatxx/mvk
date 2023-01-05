import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/constatnt/ui_constant.dart';
import 'package:mvk/state/playlsit/providers/basic_player_provider.dart';
import 'package:mvk/views/components/panel/play_pause_button.dart';
import 'package:mvk/views/components/panel/random_indicator_button.dart';

class MusicPanel extends ConsumerWidget {
  const MusicPanel({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: UiConstant.panelSize,
      child: Container(
        color: Colors.black,
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
                  onPressed: () {
                    ref.read(basicPlayerProvder).playNextTrack();
                  },
                  icon: const Icon(
                    Icons.chevron_right,
                  ),
                ),
                const RandomIndicatorButton()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
