import 'package:flutter/cupertino.dart';

@immutable
class CredentialModel {
  final String token;
  final String secret;
  final String? redirectUri;
  final String? errorType;

  const CredentialModel({
    required this.token,
    required this.secret,
    this.redirectUri,
    this.errorType,
  });

  @override
  bool operator ==(covariant CredentialModel other) =>
      identical(this, other) ||
      (token == other.token &&
          secret == other.secret &&
          redirectUri == other.redirectUri &&
          errorType == other.errorType);

  @override
  int get hashCode => Object.hash(
        token,
        secret,
        redirectUri,
        errorType,
      );
}
