import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';

final musicPositionProvider = FutureProvider(
  (ref) async {
    ref.watch(tikerProvider);

    final player = ref.read(playerProvider);
    return await player.getCurrentPosition() ?? const Duration();
  },
);

final tikerProvider = StreamProvider<int>(
  (ref) {
    return Stream.periodic(const Duration(seconds: 1), (number) => number);
  },
);
