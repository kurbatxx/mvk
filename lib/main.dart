import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvk/state/auth/providers/initial_provider.dart';
import 'package:mvk/views/login_view.dart';
import 'package:mvk/views/playlist_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final asyncLogin = ref.watch(initialProvider);
            return asyncLogin.when(
              data: (isLogin) {
                if (isLogin) {
                  return const PlaylistView();
                }
                return const LoginView();
              },
              error: (error, stackTrace) {
                return Center(
                  child: Text(error.toString()),
                );
              },
              loading: () {
                return const Scaffold(
                  body: Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
