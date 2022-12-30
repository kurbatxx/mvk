import 'package:audioplayers/audioplayers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/music_len_provider.dart';
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

    ref.invalidate(playerStateProvider);
  }

  void playOrPause({required String url}) async {
    final player = ref.read(playerProvider);
    final source = ref.read(sourceProvider);

    final playerState = ref.read(playerStateProvider);

    if (source == url) {
      final audio = UrlSource(source);
      switch (playerState) {
        case PlayerState.stopped:
          await player.play(audio);
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
      final audio = UrlSource(url);
      ref.read(sourceProvider.notifier).state = url;
      await player.stop();
      await player.play(audio);

      final duration = await player.getDuration();
      final double musicLen = duration?.inSeconds.toDouble() ?? 0.0;
      ref.read(musicLenProvider.notifier).state = musicLen;
    }
    ref.invalidate(playerStateProvider);
  }
}
