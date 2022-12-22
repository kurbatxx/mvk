import 'package:flutter/material.dart';
import 'package:mvk/state/auth/models/crededential_model.dart';

@immutable
class AuthState {
  final CredentialModel result;
  final bool isLoading;

  const AuthState({
    required this.result,
    required this.isLoading,
  });

  const AuthState.unknown()
      : result = const CredentialModel(token: '', secret: ''),
        isLoading = false;

  AuthState copyWithIsLoading(bool isLoading) =>
      AuthState(result: result, isLoading: isLoading);

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result && isLoading == other.isLoading);

  @override
  int get hashCode => Object.hash(
        result,
        isLoading,
      );
}
