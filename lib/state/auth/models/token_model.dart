class TokenModel {
  final String token;
  final String secret;

  const TokenModel({
    required this.token,
    required this.secret,
  });

  @override
  bool operator ==(covariant TokenModel other) =>
      identical(this, other) ||
      (token == other.token && secret == other.secret);

  @override
  int get hashCode => Object.hash(
        token,
        secret,
      );
}
