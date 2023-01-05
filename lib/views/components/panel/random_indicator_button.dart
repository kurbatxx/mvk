import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/playlsit/providers/play_random_provider.dart';

class RandomIndicatorButton extends ConsumerWidget {
  const RandomIndicatorButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRandom = ref.watch(playRandomProvider);

    return IconButton(
      onPressed: () {
        isRandom
            ? ref.read(playRandomProvider.notifier).state = false
            : ref.read(playRandomProvider.notifier).state = true;
      },
      icon: Icon(
        FontAwesomeIcons.shuffle,
        color: isRandom ? Colors.white : Colors.white24,
      ),
    );
  }
}
