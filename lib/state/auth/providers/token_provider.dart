import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/auth/models/token_model.dart';

final tokenProvider = StateProvider(
  (ref) => const TokenModel(token: '', secret: ''),
);
