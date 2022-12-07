import 'package:hooks_riverpod/hooks_riverpod.dart';

final loginProvider = FutureProvider<String?>((ref) async {
  await Future.delayed(const Duration(seconds: 2));

  return null;
});
