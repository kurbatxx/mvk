import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/basic_player_provider.dart';
import 'package:mvk/state/playlsit/providers/music_list_provider.dart';
import 'package:mvk/state/playlsit/providers/source_provider.dart';
import 'package:mvk/views/components/play_pause_tile.dart';

class MusicItemsList extends ConsumerWidget {
  const MusicItemsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicList = ref.watch(musicListProvider);

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: musicList.length,
        itemBuilder: (context, index) {
          final musicItem = musicList[index];
          final bool visible =
              ref.watch(sourceProvider) == musicItem.url ? true : false;

          return ListTile(
            onTap: () {
              ref.read(basicPlayerProvder).playOrPause(url: musicItem.url);
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
    );
  }
}
