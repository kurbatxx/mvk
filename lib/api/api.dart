import 'package:mvk/state/auth/models/crededential_model.dart';
import 'package:requests/requests.dart';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';

// Основное VK API. P.S: Обязательно нужен args
Future<Map<String, dynamic>> vkApi(
    String token, String secret, String method, String args) async {
  final deviceId = getRandomString(16);
  const v = 5.95;

  final url =
      '/method/$method?v=$v&access_token=$token&device_id=$deviceId&$args';
  final hash = md5.convert(utf8.encode(url + secret));

  final resp = await Requests.get('https://api.vk.com$url&sig=$hash', headers: {
    "User-Agent":
        "VKAndroidApp/4.13.1-1206 (Android 4.4.3; SDK 19; armeabi; ; ru)",
    "Accept": "image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*"
  });

  return resp.json();
}

// Логиним пользователя. Возвращает токен, секрет, ссылку для перехода и ошибку, если есть
Future<CredentialModel> vkLogin(String login, String password) async {
  final loginQueue = await Requests.post(
    "https://oauth.vk.com/token",
    headers: {
      "User-Agent":
          "VKAndroidApp/4.13.1-1206 (Android 4.4.3; SDK 19; armeabi; ; ru)",
      "Accept": "image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*"
    },
    queryParameters: {
      '2fa_supported': '1',
      'grant_type': 'password',
      'scope': 'nohttps,audio',
      'client_id': 2274003,
      'client_secret': 'hHbZxrka2uZ6jB1inYsH',
      'validate_token': 'true',
      'username': login,
      'password': password
    },
    timeoutSeconds: 20,
  );

  final result = loginQueue.json();

  var token = result['access_token'];
  var secret = result['secret'];
  var redirectUri = result['redirect_uri'];
  var errorType = result['error_type'];

  // Не обязательно, но если токен для музыки не верный, то уберите комментарий
  /*
    await vkApi(token, secret, 'execute.getUserInfo', 'func_v=9');
    await vkApi(token, secret, 'auth.refreshToken', 'lang=\'ru\'');
  */

  final credential = CredentialModel(
    secret: secret ?? '',
    token: token ?? '',
    redirectUri: redirectUri,
    errorType: errorType,
  );

  return credential;
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
