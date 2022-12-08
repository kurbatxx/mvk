import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/api/api.dart';
import 'package:mvk/ext/ext_log.dart';


class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginController = useTextEditingController();
    final passwordController = useTextEditingController();

    useEffect(() {}, [loginController, passwordController]);

    return Scaffold(
      body: Column(
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
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 300,
              maxWidth: 300,
            ),
            child: ElevatedButton(
              onPressed: () async {
                final login = loginController.text;
                final password = passwordController.text;
                final logged = await vkLogin(login, password);
                logged.log();

                //await SecureStorage().setToken(logged['token']);
                //await SecureStorage().setSecret(logged['secret']);
              },
              child: const Text('Войти'),
            ),
          )
        ],
      ),
    );
  }
}
