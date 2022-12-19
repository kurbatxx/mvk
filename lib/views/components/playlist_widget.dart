import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';
import 'package:mvk/state/playlsit/providers/player_state_provider.dart';
import 'package:mvk/state/playlsit/providers/playlist_provider.dart';
import 'package:mvk/state/playlsit/providers/source_provider.dart';
import 'package:mvk/views/components/play_pause_tile.dart';

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
            final bool visible =
                ref.watch(sourceProvider) == musicItem.url ? true : false;
            return ListTile(
              onTap: () async {
                final player = ref.read(audioPlayerProvider);
                final source = ref.read(sourceProvider);
                final audio = UrlSource(musicItem.url);

                if (source != musicItem.url) {
                  await player.stop();
                  await player.play(audio);
                  ref.read(sourceProvider.notifier).state = musicItem.url;
                } else {
                  if (player.state != PlayerState.playing) {
                    await player.play(audio);
                  } else {
                    await player.pause();
                  }
                }
                final _ = ref.refresh(audioPlayerStateProvider);
              },
              leading: Visibility(
                visible: visible,
                child: const PlayPauseTile(),
              ),
              title: Text(
                musicItem.title,
              ),
              subtitle: Text(
                musicItem.artist,
              ),
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
