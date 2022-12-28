import 'package:audioplayers/audioplayers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';

final playerStateProvider = StateProvider<PlayerState>((ref) {
  return ref.watch(playerProvider.select((player) => player.state));
});
