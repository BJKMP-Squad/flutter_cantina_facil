import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/data/supabase_auth_repository.dart';
import '../../features/auth/presentation/login_page.dart';
import '../../features/auth/presentation/profile_page.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refresh = ValueNotifier(0);
  ref.listen(authUserIdProvider, (previous, next) => refresh.value++);
  final router = GoRouter(
    initialLocation: '/',
    refreshListenable: refresh,
    redirect: (context, state) {
      final session = ref.read(authUserIdProvider);
      final path = state.uri.path;
      if (session.isLoading) {
        return path == '/carregando' ? null : '/carregando';
      }
      if (session.hasError) {
        return path == '/erro-sessao' ? null : '/erro-sessao';
      }
      final userId = session.value;
      if (userId == null) return path == '/login' ? null : '/login';
      if (path == '/' ||
          path == '/login' ||
          path == '/carregando' ||
          path == '/erro-sessao') {
        return '/conta';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const _LoadingPage()),
      GoRoute(
        path: '/carregando',
        builder: (context, state) => const _LoadingPage(),
      ),
      GoRoute(
        path: '/erro-sessao',
        builder: (context, state) => const _SessionErrorPage(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/conta',
        builder: (context, state) => const _AccountRoute(),
      ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });
  return router;
}

class _AccountRoute extends ConsumerWidget {
  const _AccountRoute();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authUserIdProvider);
    final userId = session.value;
    if (session.isLoading || session.hasError || userId == null) {
      return const _LoadingPage();
    }
    return ProfilePage(key: ValueKey(userId), userId: userId);
  }
}

class _LoadingPage extends StatelessWidget {
  const _LoadingPage();

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}

class _SessionErrorPage extends ConsumerWidget {
  const _SessionErrorPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Não foi possível verificar a sessão.'),
            TextButton(
              onPressed: () => ref.invalidate(authUserIdProvider),
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
