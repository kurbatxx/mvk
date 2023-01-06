import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/constatnt/ui_constant.dart';
import 'package:mvk/state/playlsit/models/music.dart';
import 'package:mvk/state/playlsit/providers/basic_player_provider.dart';
import 'package:mvk/state/playlsit/providers/source_provider.dart';
import 'package:mvk/views/components/play_pause_tile.dart';

class MusicItemWidget extends ConsumerWidget {
  final MusicItem musicItem;
  const MusicItemWidget({required this.musicItem, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool visible =
        ref.watch(sourceProvider) == musicItem.url ? true : false;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 2.0,
        vertical: 1.0,
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(UiConstant.borderTileRadius),
        ),
        child: InkWell(
          onTap: () {
            ref.read(basicPlayerProvder).playOrPause(url: musicItem.url);
          },
          borderRadius: BorderRadius.circular(UiConstant.borderTileRadius),
          child: ListTile(
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
          ),
        ),
      ),
    );
  }
}
