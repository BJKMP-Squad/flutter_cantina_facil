import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'package:flutter_cantina_facil/src/features/auth/data/supabase_auth_repository.dart';
import 'package:flutter_cantina_facil/src/features/auth/domain/auth_repository.dart';
import 'package:flutter_cantina_facil/src/features/auth/domain/profile.dart';
import 'package:flutter_cantina_facil/src/core/router/app_router.dart';
import 'package:flutter_cantina_facil/src/features/auth/presentation/auth_localizations.dart';

class FakeAuthRepository implements AuthRepository {
  final events = StreamController<String?>.broadcast();
  String? userId;
  bool failProfile = false;
  bool failSignOut = false;
  Completer<void>? signOutCompleter;
  int profileRequests = 0;
  String? lastProfileUserId;

  @override
  Stream<String?> authUserIds() async* {
    yield userId;
    yield* events.stream;
  }

  @override
  Future<Profile> getProfile(String userId) async {
    profileRequests++;
    lastProfileUserId = userId;
    if (failProfile) throw StateError('profile error');
    return Profile(
      id: userId,
      nome: 'Ana',
      email: 'ana@example.com',
      role: 'responsavel',
    );
  }

  @override
  Future<void> signOut() async {
    if (failSignOut) throw StateError('sign out error');
    await signOutCompleter?.future;
    userId = null;
    events.add(null);
  }
}

class MemoryPkceStorage extends GotrueAsyncStorage {
  final Map<String, String> values = {};

  @override
  Future<String?> getItem({required String key}) async => values[key];

  @override
  Future<void> setItem({required String key, required String value}) async {
    values[key] = value;
  }

  @override
  Future<void> removeItem({required String key}) async {
    values.remove(key);
  }
}

class TestApp extends ConsumerWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
    locale: const Locale('pt', 'BR'),
    supportedLocales: const [Locale('pt', 'BR')],
    localizationsDelegates: authLocalizationsDelegates,
    routerConfig: ref.watch(appRouterProvider),
  );
}

void main() {
  setUpAll(() async {
    await Supabase.initialize(
      url: 'https://example.supabase.co',
      publishableKey: 'test-key',
      authOptions: FlutterAuthClientOptions(
        localStorage: const EmptyLocalStorage(),
        pkceAsyncStorage: MemoryPkceStorage(),
      ),
    );
  });

  Future<void> showGate(
    WidgetTester tester,
    FakeAuthRepository repository,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
        child: const TestApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('sessão direciona ao perfil e logout retorna ao login', (
    tester,
  ) async {
    final repository = FakeAuthRepository();
    addTearDown(repository.events.close);
    await showGate(tester, repository);

    expect(find.text('Acesse sua conta'), findsOneWidget);
    expect(repository.profileRequests, 0);

    final container = ProviderScope.containerOf(
      tester.element(find.byType(TestApp)),
    );
    container.read(appRouterProvider).go('/conta');
    await tester.pumpAndSettle();
    expect(
      container.read(appRouterProvider).routeInformationProvider.value.uri.path,
      '/login',
    );

    repository.events.add('user-1');
    await tester.pumpAndSettle();
    expect(find.text('Ana'), findsOneWidget);
    expect(find.text('Perfil: responsavel'), findsOneWidget);
    expect(
      container.read(appRouterProvider).routeInformationProvider.value.uri.path,
      '/conta',
    );

    repository.events.add('user-2');
    await tester.pumpAndSettle();
    expect(repository.lastProfileUserId, 'user-2');

    await tester.tap(find.text('Sair'));
    await tester.pumpAndSettle();
    expect(find.text('Acesse sua conta'), findsOneWidget);
  });

  testWidgets('erro de sessão apresenta opção de tentar novamente', (
    tester,
  ) async {
    final repository = FakeAuthRepository();
    addTearDown(repository.events.close);
    await showGate(tester, repository);
    repository.events.addError(StateError('session error'));
    await tester.pumpAndSettle();
    expect(find.text('Não foi possível verificar a sessão.'), findsOneWidget);
    await tester.tap(find.text('Tentar novamente'));
    await tester.pumpAndSettle();
    expect(find.text('Acesse sua conta'), findsOneWidget);
  });

  testWidgets('perfil falho pode ser carregado novamente', (tester) async {
    final repository = FakeAuthRepository()
      ..userId = 'user-1'
      ..failProfile = true;
    addTearDown(repository.events.close);
    await showGate(tester, repository);
    expect(find.text('Não foi possível carregar o perfil.'), findsOneWidget);

    repository.failProfile = false;
    await tester.tap(find.text('Tentar novamente'));
    await tester.pumpAndSettle();
    expect(find.text('Ana'), findsOneWidget);
  });

  testWidgets('erro ao sair mantém a sessão e informa o usuário', (
    tester,
  ) async {
    final repository = FakeAuthRepository()
      ..userId = 'user-1'
      ..failSignOut = true;
    addTearDown(repository.events.close);
    await showGate(tester, repository);
    await tester.tap(find.text('Sair'));
    await tester.pumpAndSettle();
    expect(find.text('Ana'), findsOneWidget);
    expect(
      find.text('Não foi possível sair. Tente novamente.'),
      findsOneWidget,
    );
  });

  testWidgets('logout pendente desabilita o botão até a operação terminar', (
    tester,
  ) async {
    final repository = FakeAuthRepository()
      ..userId = 'user-1'
      ..signOutCompleter = Completer<void>();
    addTearDown(repository.events.close);
    await showGate(tester, repository);
    await tester.tap(find.text('Sair'));
    await tester.pump();
    expect(
      tester
          .widget<TextButton>(find.widgetWithText(TextButton, 'Saindo...'))
          .onPressed,
      isNull,
    );
    repository.signOutCompleter!.complete();
    await tester.pumpAndSettle();
    expect(find.text('Acesse sua conta'), findsOneWidget);
  });

  testWidgets('formulário rejeita e-mail inválido', (tester) async {
    final repository = FakeAuthRepository();
    addTearDown(repository.events.close);
    await showGate(tester, repository);
    await tester.enterText(find.byType(TextFormField).first, 'invalido');
    await tester.enterText(find.byType(TextFormField).at(1), 'senha123');
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();
    expect(find.text('Informe um e-mail válido.'), findsOneWidget);
  });

  testWidgets('cadastro aguarda confirmação e recuperação está desativada', (
    tester,
  ) async {
    final repository = FakeAuthRepository();
    addTearDown(repository.events.close);
    await showGate(tester, repository);

    final form = tester.widget<SupaEmailAuth>(find.byType(SupaEmailAuth));
    form.onSignUpComplete(AuthResponse());
    await tester.pump();
    expect(
      find.text('Confira seu e-mail para confirmar o cadastro.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Esqueci minha senha'));
    await tester.pumpAndSettle();
    expect(
      find.text('A recuperação de senha ainda não está disponível.'),
      findsOneWidget,
    );
    expect(find.byType(SupaEmailAuth), findsNothing);
    await tester.tap(find.text('Voltar para o login'));
    await tester.pumpAndSettle();
    expect(find.byType(SupaEmailAuth), findsOneWidget);
  });
}
