import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/api/api.dart';
import 'package:mvk/ext/ext_log.dart';

import 'package:mvk/state/auth/providers/token_provider.dart';

final playlistProvider = FutureProvider<Iterable<bool>>((ref) async {
  final token = ref.read(tokenProvider);
  token.token.log();
  token.secret.log();

  final res = await vkApi(
    token.token,
    token.secret,
    'audio.get',
    'count=10000',
  );

  return [];
});
