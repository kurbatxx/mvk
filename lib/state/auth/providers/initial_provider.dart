import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/api/api.dart';
import 'package:mvk/secure/secure_storage.dart';

final initialProvider = FutureProvider<bool>(
  (ref) async {
    await Future.delayed(const Duration(seconds: 2));
    final token = await SecureStorage().getToken();
    final secret = await SecureStorage().getSecret();

    if (token.isNotEmpty && secret.isNotEmpty) {
      final validAudioCheck = await vkApi(
        token,
        secret,
        'audio.get',
        'count=1',
      );

      if (validAudioCheck['error'] != null) {
        return false;
      }
      return true;
    }
    return false;
  },
);
