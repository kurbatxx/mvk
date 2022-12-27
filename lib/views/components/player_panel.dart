import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/constatnt/ui_constant.dart';
import 'package:mvk/ext/ext_log.dart';
import 'package:mvk/state/playlsit/providers/duration_provider.dart';

class PlayerPanel extends HookConsumerWidget {
  const PlayerPanel({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureDuration = ref.watch(tickerProvider);
    '--BUILD--'.log();

    return futureDuration.when(
      data: (data) {
        final dur = ref.read(data);
        return dur.when(
          data: (Duration? data) {
            return Center(child: Text((data?.inSeconds ?? 0).toString()));
          },
          error: (Object error, StackTrace stackTrace) {
            return const Text('error');
          },
          loading: () {
            return const Text('loading');
          },
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () {
        return const SizedBox(
          height: UiConstant.circularProgressIndicatorSize,
          width: UiConstant.circularProgressIndicatorSize,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
