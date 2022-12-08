import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/api/api.dart';
import 'package:mvk/secure/secure_storage.dart';
import 'package:mvk/ext/ext_log.dart';

final loginProvider = FutureProvider<bool>(
  (ref) async {
    await Future.delayed(const Duration(seconds: 2));
    String? token = await SecureStorage().getToken();
    String? secret = await SecureStorage().getSecret();

    token.log();
    secret.log();

    if (token != null && secret != null) {
      final validAudioCheck = await vkApi(
        token,
        secret,
        'audio.get',
        'count=1',
      );

      if (validAudioCheck['error'] != null) {
        if (validAudioCheck['error']['error_code'] == 25) {
          return false;
        } else {
          return true;
        }
      }
      return false;
    }
    return false;
  },
);
