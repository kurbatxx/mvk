import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//import 'package:just_audio/just_audio.dart';
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
              onTap: () async {
                final player = AudioPlayer();
                //final audio = UrlSource(musicItem.url);
                // final audio = UrlSource(
                //    "https://vgmsite.com/soundtracks/splinter-cell/ijsqbelh/31.%20Name%20of%20the%20Game%20%5BEdit%5D.mp3");
                final audio = AssetSource('minus.mp3');
                await player.play(audio);
              },
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
