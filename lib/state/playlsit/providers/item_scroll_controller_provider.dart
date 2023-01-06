import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

final itemScrollcontrollerProvider = Provider((ref) {
  return ItemScrollController();
});
