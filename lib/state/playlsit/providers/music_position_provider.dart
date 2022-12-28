import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';

final musicPositionProvider = FutureProvider(
  (ref) async {
    final player = ref.read(playerProvider);
    return await player.getCurrentPosition() ?? const Duration();
  },
);
