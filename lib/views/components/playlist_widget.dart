import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/playlist_provider.dart';

class PlaylistWidget extends ConsumerWidget {
  const PlaylistWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlist = ref.watch(playlistProvider);

    return playlist.when(
      data: (data) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.response.musicItems.length,
          itemBuilder: (context, index) {
            final musicItem = data.response.musicItems[index];
            return ListTile(
              title: Text(
                musicItem.title,
              ),
              subtitle: Text(musicItem.artist),
            );
          },
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(
          error.toString(),
        ),
      ),
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
