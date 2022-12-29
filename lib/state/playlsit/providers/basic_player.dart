import 'package:audioplayers/audioplayers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/music_list_provider.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';
import 'package:mvk/state/playlsit/providers/player_state_provider.dart';
import 'package:mvk/state/playlsit/providers/source_provider.dart';

final basicPlayerProvder = Provider((ref) => BasicPlayer(ref));

class BasicPlayer {
  BasicPlayer(this.ref);
  final Ref ref;

  void play() async {
    final player = ref.read(playerProvider);
    String source = ref.read(sourceProvider);
    if (source.isEmpty) {
      final musicItem = ref.read(musicListProvider).first;
      source = musicItem.url;
      ref.read(sourceProvider.notifier).state = source;
    }

    final audio = UrlSource(source);
    await player.play(audio);
    ref.invalidate(playerStateProvider);
  }

  void pause() async {
    final player = ref.read(playerProvider);
    await player.pause();
  }
}
