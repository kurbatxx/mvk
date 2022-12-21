import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/player_provider.dart';

final tickerProvider = StreamProvider(
  (ref) => Stream.periodic(
    const Duration(seconds: 1),
    (i) {
      final _ = ref.refresh(durationProvider);
      return durationProvider;
    },
  ),
);

final durationProvider = FutureProvider((ref) async {
  return await ref.read(audioPlayerProvider).getCurrentPosition();
});
