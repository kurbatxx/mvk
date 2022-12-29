import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/music_len_provider.dart';
import 'package:mvk/state/playlsit/providers/music_list_provider.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';
import 'package:mvk/state/playlsit/providers/player_state_provider.dart';
import 'package:mvk/state/playlsit/providers/source_provider.dart';
import 'package:mvk/views/components/music_panel.dart';
import 'package:mvk/views/components/play_pause_tile.dart';

class MusicItemsListWidget extends ConsumerWidget {
  const MusicItemsListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.read(playerProvider);
    final musicList = ref.watch(musicListProvider);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: musicList.length,
            itemBuilder: (context, index) {
              final musicItem = musicList[index];
              final bool visible =
                  ref.watch(sourceProvider) == musicItem.url ? true : false;

              return ListTile(
                onTap: () async {
                  final playerState = ref.read(playerStateProvider);
                  final source = ref.read(sourceProvider);

                  final audio = UrlSource(musicItem.url);

                  if (source == musicItem.url) {
                    switch (playerState) {
                      case PlayerState.stopped:
                        await player.play(audio);
                        ref.read(sourceProvider.notifier).state = musicItem.url;
                        break;
                      case PlayerState.playing:
                        await player.pause();
                        break;
                      case PlayerState.paused:
                        await player.play(audio);
                        break;
                      case PlayerState.completed:
                        await player.play(audio);
                        break;
                    }
                  } else {
                    ref.read(sourceProvider.notifier).state = musicItem.url;
                    await player.stop();
                    await player.play(audio);

                    final duration = await player.getDuration();
                    final double musicLen =
                        duration?.inSeconds.toDouble() ?? 0.0;
                    ref.read(musicLenProvider.notifier).state = musicLen;
                  }
                  ref.refresh(playerStateProvider);
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
        const MusicPanel(),
      ],
    );
  }
}
