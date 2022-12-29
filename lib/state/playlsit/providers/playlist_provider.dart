import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/api/api.dart';
import 'package:mvk/ext/ext_log.dart';
import 'package:mvk/state/auth/providers/auth_state_provider.dart';
import 'package:mvk/state/playlsit/models/music.dart';
import 'package:mvk/state/playlsit/providers/music_list_provider.dart';

final playlistProvider = FutureProvider<Music>((ref) async {
  final token = ref.read(authStateProvider).result;
  token.token.log();
  token.secret.log();

  final musicResponse = await vkApi(
    token.token,
    token.secret,
    'audio.get',
    'count=10000',
  );

  final music = Music.fromJson(musicResponse);

  ref.read(musicListProvider.notifier).state = music.response.musicItems;
  return music;
});
