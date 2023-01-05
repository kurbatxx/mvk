import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';
import 'package:mvk/state/playlsit/providers/player_state_stream_provider.dart';

final musicPositionProvider = StreamProvider<Duration>(
  (ref) {
    final player = ref.read(playerProvider);

    Duration dur = const Duration();
    final controller = StreamController<Duration>();
    controller.add(dur);

    ref.watch(tikerProvider.stream).forEach(
      (event) {
        final state = ref.read(playerStateStreamProvider);

        switch (state.value) {
          case PlayerState.stopped:
          case PlayerState.completed:
            controller.add(
              const Duration(seconds: 0),
            );
            break;

          case PlayerState.playing:
            final duration = player.getCurrentPosition();

            duration.then(
              (value) {
                dur = value ?? const Duration(seconds: 0);
                controller.add(dur);
              },
            );
            break;
          case PlayerState.paused:
            break;
          default:
            break;
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
