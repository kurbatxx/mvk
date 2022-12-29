import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/ext/ext_duration.dart';
import 'package:mvk/state/playlsit/providers/music_position_provider.dart';
import 'package:mvk/views/components/circular_indicator.dart';

class TimerCheapDetails extends ConsumerWidget {
  const TimerCheapDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = ref.watch(musicPositionProvider);

    return duration.when(
      data: (data) {
        return Text(
          durationToFormat(data),
          style: const TextStyle(color: Colors.black),
        );
      },
      error: (error, stackTrace) => const Text('error'),
      loading: () {
        return const CircularIndicator();
      },
    );
  }
}
