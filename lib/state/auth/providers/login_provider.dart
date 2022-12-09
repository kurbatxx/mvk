import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/api/api.dart';
import 'package:mvk/secure/secure_storage.dart';
import 'package:mvk/state/auth/models/token_model.dart';
import 'package:mvk/state/auth/providers/credential_provider.dart';
import 'package:mvk/ext/ext_log.dart';
import 'package:mvk/state/auth/providers/token_provider.dart';

final loginProvider = FutureProvider<bool>(
  (ref) async {
    final credential = ref.watch(credentialProvider);

    String? token = credential.token;
    String? secret = credential.secret;

    if (credential.token == null || credential.secret == null) {
      await Future.delayed(const Duration(seconds: 2));
      token = await SecureStorage().getToken();
      secret = await SecureStorage().getSecret();
      token.log();
      secret.log();
    }

    if (token != null && secret != null) {
      final validAudioCheck = await vkApi(
        token,
        secret,
        'audio.get',
        'count=1',
      );

      print(validAudioCheck['error']);

      if (validAudioCheck['error'] != null) {
        if (validAudioCheck['error']['error_code'] == 25) {
          return false;
        }
      }
      await SecureStorage().setToken(token);
      await SecureStorage().setSecret(secret);
      ref.read(tokenProvider.notifier).state = TokenModel(
        token: token,
        secret: secret,
      );
      return true;
    }
    return false;
  },
);
