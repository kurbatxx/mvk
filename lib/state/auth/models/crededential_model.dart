class CredentialModel {
  final String? token;
  final String? secret;

  const CredentialModel({
    required this.token,
    required this.secret,
  });

  @override
  bool operator ==(covariant CredentialModel other) =>
      identical(this, other) ||
      (token == other.token && secret == other.secret);

  @override
  int get hashCode => Object.hash(
        token,
        secret,
      );
}
