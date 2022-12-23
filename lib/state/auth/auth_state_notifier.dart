import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/api/api.dart';
import 'package:mvk/secure/secure_storage.dart';
import 'package:mvk/state/auth/models/auth_state.dart';
import 'package:mvk/state/auth/models/crededential_model.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(const AuthState.unknown());

  Future<void> logout() async {
    await SecureStorage().delToken();
    await SecureStorage().delSecret();
    state = const AuthState.unknown();
  }

  Future<void> login(login, password) async {
    state = state.copyWithIsLoading(true);
    final credential = await vkLogin(login, password);

    if (credential.secret.isNotEmpty && credential.secret.isNotEmpty) {
      await SecureStorage().setToken(credential.token);
      await SecureStorage().setSecret(credential.token);
    }

    state = AuthState(
      result: credential,
      isLoading: false,
    );
  }

  void update(token, secret) {
    state = state = AuthState(
      result: CredentialModel(
        token: token,
        secret: secret,
      ),
      isLoading: false,
    );
  }
}
