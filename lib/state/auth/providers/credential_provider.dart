import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/auth/models/crededential_model.dart';

final credentialProvider = StateProvider(
  (ref) => const CredentialModel(
    token: null,
    secret: null,
  ),
);
