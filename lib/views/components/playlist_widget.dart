import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/ext/ext_log.dart';
import 'package:mvk/state/playlsit/providers/duration_provider.dart';
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
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
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
              ),
            ),
            SizedBox(
              height: 60,
              child: Consumer(
                builder: (context, ref, child) {
                  final futureDuration = ref.watch(tickerProvider);
                  '--BUILD--'.log();
                  return futureDuration.when(
                    data: (data) {
                      final dur = ref.read(data);
                      return dur.when(
                        data: (Duration? data) {
                          return Text((data?.inSeconds ?? 0).toString());
                        },
                        error: (Object error, StackTrace stackTrace) {
                          return const Text('error');
                        },
                        loading: () {
                          return const Text('loading');
                        },
                      );
                    },
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(
          error.toString(),
        ),
      ),
      loading: () {
        return const Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
