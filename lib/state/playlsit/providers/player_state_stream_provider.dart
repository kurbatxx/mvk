import 'package:audioplayers/audioplayers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';

final playerStateStreamProvider = StreamProvider<PlayerState>(
  (ref) {
    final player = ref.read(playerProvider);
    return player.onPlayerStateChanged;
  },
);
