import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/music_list_provider.dart';
import 'package:mvk/views/components/music_list/music_item_widget.dart';

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
          return MusicItemWidget(
            musicItem: musicItem,
          );
        },
      ),
    );
  }
}
