import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/api/api.dart';
import 'package:mvk/secure/secure_storage.dart';
import 'package:mvk/state/auth/models/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(const AuthState.unknown());

  Future<void> logout() async {
    state = state.copyWithIsLoading(true);
    state = const AuthState.unknown();
  }

  Future<void> login(login, password) async {
    state = state.copyWithIsLoading(true);
    final credential = await vkLogin(login, password);

    if (credential.secret.isNotEmpty && credential.secret.isNotEmpty) {
      final storage = SecureStorage();
      storage.setToken(credential.token);
      storage.setSecret(credential.secret);
    }

    state = AuthState(
      result: credential,
      isLoading: false,
    );
  }
}
