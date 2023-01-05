import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/ext/ext_log.dart';
import 'package:mvk/state/playlsit/providers/basic_player_provider.dart';
import 'package:mvk/state/playlsit/providers/playlist_provider.dart';
import 'package:mvk/state/playlsit/providers/player_state_stream_provider.dart';
import 'package:mvk/views/components/circular_indicator.dart';
import 'package:mvk/views/components/music_items_list_widget.dart';

class PlaylistWidget extends ConsumerWidget {
  const PlaylistWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      playerStateStreamProvider,
      (_, currentState) {
        '--${currentState.value}'.log();
        if (currentState.value == PlayerState.completed) {
          Future.delayed(
            const Duration(seconds: 7),
          ).whenComplete(
            () => ref.read(basicPlayerProvder).playNextTrack(),
          );
        }
      },
    );

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
