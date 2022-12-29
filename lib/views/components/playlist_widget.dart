import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/music_list_provider.dart';
import 'package:mvk/state/playlsit/providers/playlist_provider.dart';

import 'package:mvk/views/components/circular_indicator.dart';
import 'package:mvk/views/components/music_items_list_widget.dart';

class PlaylistWidget extends ConsumerWidget {
  const PlaylistWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final player = ref.read(playerProvider);
    // ref.listen(playerStateProvider, (previous, curent) {
    //   'lisen+++_$curent'.log();
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
