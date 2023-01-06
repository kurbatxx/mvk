import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/playlist_provider.dart';
import 'package:mvk/views/components/circular_indicator.dart';
import 'package:mvk/views/components/music_list/music_items_list_with_panel.dart';

class PlaylistWidget extends ConsumerWidget {
  const PlaylistWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlist = ref.watch(playlistProvider);

    return playlist.when(
      data: (data) {
        return const MusicItemsListWithPanel();
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
