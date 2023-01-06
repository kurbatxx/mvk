import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/item_scroll_controller_provider.dart';
import 'package:mvk/state/playlsit/providers/music_list_provider.dart';
import 'package:mvk/views/components/music_list/music_item_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MusicItemsList extends ConsumerWidget {
  const MusicItemsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicList = ref.watch(musicListProvider);
    final controller = ref.watch(itemScrollcontrollerProvider);

    return Expanded(
      child: ScrollablePositionedList.builder(
        shrinkWrap: true,
        itemCount: musicList.length,
        itemScrollController: controller,
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
