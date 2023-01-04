import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/ext/ext_log.dart';
import 'package:mvk/state/playlsit/providers/basic_player_provider.dart';
import 'package:mvk/state/playlsit/providers/player_state_provider.dart';
import 'package:mvk/state/playlsit/providers/playlist_provider.dart';
import 'package:mvk/state/playlsit/providers/state_provider.dart';
import 'package:mvk/views/components/circular_indicator.dart';
import 'package:mvk/views/components/music_items_list_widget.dart';

class PlaylistWidget extends ConsumerWidget {
  const PlaylistWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      stateProvider,
      (previous, next) {
        if (next.hasValue) {
          '--${next.value}'.log();
          if (next.value == PlayerState.completed) {
            () async {
              await Future.delayed(
                const Duration(seconds: 1),
              );
              ref.read(basicPlayerProvder).playNextTrack();
            };
          }
        }
      },
    );
    // ref.listen(playerStateProvider, (previous, curent) {
    //   '_+++_$curent'.log();
    //   if (curent == PlayerState.completed) {
    //     () async {
    //       await Future.delayed(
    //         const Duration(seconds: 1),
    //       );
    //       ref.read(basicPlayerProvder).playNextTrack();
    //     };
    //   }
    // });

    final playlist = ref.watch(playlistProvider);

    return playlist.when(
      data: (data) {
        return const MusicItemsListWidget();
      },
      error: (error, stackTrace) => Center(
        child: Text(
          error.toString(),
        ),
      ),
      loading: () {
        return const CircularIndicator();
      },
    );
  }
}
