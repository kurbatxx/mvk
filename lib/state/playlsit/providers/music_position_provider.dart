import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';
import 'package:mvk/state/playlsit/providers/player_state_provider.dart';

final musicPositionProvider = StreamProvider<Duration>(
  (ref) {
    final player = ref.read(playerProvider);

    Duration dur = const Duration();
    final controller = StreamController<Duration>();
    controller.add(dur);

    ref.watch(tikerProvider.stream).forEach(
      (event) {
        final state = ref.read(playerStateProvider);

        if (state == PlayerState.playing) {
          final duration = player.getCurrentPosition();

          duration.then(
            (value) {
              dur = value ?? const Duration(seconds: 300);
              controller.add(dur);

              // if (dur == const Duration()) {
              //   ref.invalidate(playerStateProvider);
              // }
            },
          );
        }
      },
    );
    return controller.stream;
  },
);

final tikerProvider = StreamProvider<int>(
  (ref) {
    return Stream.periodic(
        const Duration(milliseconds: 200), (number) => number);
  },
);
