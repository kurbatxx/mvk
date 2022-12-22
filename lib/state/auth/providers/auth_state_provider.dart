import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/auth/auth_state_notifier.dart';
import 'package:mvk/state/auth/models/auth_state.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(),
);
