import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';
import 'package:mvk/state/playlsit/providers/player_state_provider.dart';

final musicPositionProvider = StreamProvider<Duration>(
  (ref) {
    Duration dur = const Duration();
    final controller = StreamController<Duration>();
    controller.add(dur);

    ref.watch(tikerProvider.stream).forEach(
      (event) {
        final state = ref.read(playerStateProvider);

        if (state == PlayerState.playing) {
          final player = ref.read(playerProvider);
          final duration = player.getCurrentPosition();

          duration.then((value) {
            dur = value ?? const Duration();
            controller.add(dur);

            if (dur == const Duration()) {
              ref.refresh(playerStateProvider);
            }
          });
        }
      },
    );
    return controller.stream;
  },
);

final tikerProvider = StreamProvider<int>(
  (ref) {
    return Stream.periodic(const Duration(seconds: 1), (number) => number);
  },
);
