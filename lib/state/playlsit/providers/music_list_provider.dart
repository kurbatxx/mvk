import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/models/music.dart';

final musicListProvider = StateProvider<List<MusicItem>>((_) {
  return <MusicItem>[];
});
