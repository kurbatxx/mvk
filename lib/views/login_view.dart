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
    final showError = useState(true);

    useEffect(
      () {
        loginController.addListener(() {
          showError.value = false;
        });
        passwordController.addListener(() {
          showError.value = false;
        });
        return () {};
      },
      [loginController, passwordController],
    );

    final state = ref.watch(authStateProvider);

    final credential = state.result;
    if (credential.secret.isNotEmpty && credential.token.isNotEmpty) {
      loginController.clear();
      passwordController.clear();
      return const PlaylistView();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Авторизация'),
      ),
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
                  SizedBox(
                    height: 32,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state.isLoading) ...[
                          const Center(
                            child: SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ] else ...[
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 300,
                              maxWidth: 300,
                              maxHeight: 32,
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                final login = loginController.text;
                                final password = passwordController.text;
                                await ref
                                    .read(authStateProvider.notifier)
                                    .login(login, password);
                                showError.value = true;
                              },
                              child: const Text('Войти'),
                            ),
                          )
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (credential.errorType != null && showError.value) ...[
                    const Text('Неправильный логин или пароль')
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
