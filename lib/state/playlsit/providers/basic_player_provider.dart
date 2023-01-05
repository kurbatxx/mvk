import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/ext/ext_log.dart';
import 'package:mvk/state/playlsit/providers/music_len_provider.dart';
import 'package:mvk/state/playlsit/providers/music_list_provider.dart';
import 'package:mvk/state/playlsit/providers/play_random_provider.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';
import 'package:mvk/state/playlsit/providers/player_state_stream_provider.dart';
import 'package:mvk/state/playlsit/providers/source_provider.dart';

final basicPlayerProvder = Provider((ref) => BasicPlayer(ref));

class BasicPlayer {
  const BasicPlayer(this.ref);
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
    await player.stop();
    await player.play(audio);
  }

  void pause() async {
    final player = ref.read(playerProvider);
    await player.pause();
  }

  void playNextTrack() {
    final source = ref.read(sourceProvider);
    final trackList = ref.read(musicListProvider);

    if (ref.read(playRandomProvider)) {
      _playRandomTrack();
    } else {
      final index = trackList.indexWhere((item) => item.url == source);
      if (index == -1) {
        return;
      }

      if (index + 1 < trackList.length) {
        ref.read(sourceProvider.notifier).state = trackList[index + 1].url;
      }
    }

    play();
  }

  void playPreTrack() {
    final source = ref.read(sourceProvider);
    final trackList = ref.read(musicListProvider);

    if (ref.read(playRandomProvider)) {
      _playRandomTrack();
    } else {
      final index = trackList.indexWhere((item) => item.url == source);
      if (index == -1) {
        return;
      }

      if (index - 1 > 0) {
        ref.read(sourceProvider.notifier).state = trackList[index - 1].url;
      }
    }

    play();
  }

  void _playRandomTrack() {
    final musicList = ref.read(musicListProvider);
    final musicTrack = musicList[Random().nextInt(musicList.length)];
    ref.read(sourceProvider.notifier).state = musicTrack.url;
  }

  void playOrPause({required String url}) async {
    final player = ref.read(playerProvider);
    String source = ref.read(sourceProvider);

    final asyncPlayerState = ref.read(playerStateStreamProvider);
    final playerState = asyncPlayerState.value ?? PlayerState.stopped;

    '**$playerState'.log();

    if (source == url) {
      if (source.isEmpty) {
        final musicItem = ref.read(musicListProvider).first;
        source = musicItem.url;
        ref.read(sourceProvider.notifier).state = source;
      }

      final audio = UrlSource(source);
      switch (playerState) {
        case PlayerState.playing:
          await player.pause();
          break;
        case PlayerState.stopped:
        case PlayerState.paused:
        case PlayerState.completed:
          await player.play(audio);
          break;
        default:
          break;
      }
    } else {
      await player.stop();
      final audio = UrlSource(url);
      ref.read(sourceProvider.notifier).state = url;
      await player.play(audio);

      final duration = await player.getDuration();
      final double musicLen = duration?.inSeconds.toDouble() ?? 0.0;
      ref.read(musicLenProvider.notifier).state = musicLen;
    }
  }
}
