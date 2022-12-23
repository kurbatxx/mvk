import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/auth/providers/auth_state_provider.dart';
import 'package:mvk/views/playlist_view.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginController = useTextEditingController();
    final passwordController = useTextEditingController();

    useEffect(() {}, [loginController, passwordController]);

    final state = ref.watch(authStateProvider);

    if (state.result.secret.isNotEmpty && state.result.token.isNotEmpty) {
      return const PlaylistView();
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: loginController,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: [
                  if (state.isLoading == true) ...[
                    const SizedBox(
                      height: 8,
                    ),
                    const Center(
                      child: SizedBox(
                        height: 14,
                        width: 14,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ] else ...[
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 300,
                        maxWidth: 300,
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          final login = loginController.text;
                          final password = passwordController.text;
                          await ref
                              .read(authStateProvider.notifier)
                              .login(login, password);
                        },
                        child: const Text('Войти'),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
