import 'package:hooks_riverpod/hooks_riverpod.dart';

final musicLenProvider = StateProvider<double>((ref) {
  return 1000.0;
});
