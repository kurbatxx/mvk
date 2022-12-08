import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  final String _token = "token";
  final String _secret = "secret";

  Future setToken(String token) async {
    await storage.write(key: _token, value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: _token);
  }

  Future delToken() async {
    return await storage.write(key: _token, value: null);
  }

  Future setSecret(String secret) async {
    await storage.write(key: _secret, value: secret);
  }

  Future<String?> getSecret() async {
    return await storage.read(key: _secret);
  }

  Future delSecret() async {
    return await storage.write(key: _secret, value: null);
  }
}
