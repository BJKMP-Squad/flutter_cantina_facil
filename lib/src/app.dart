import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/router/app_router.dart';
import 'core/theme/theme.dart';
import 'core/theme/util.dart';
import 'features/auth/presentation/auth_localizations.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final theme = MaterialTheme(createTextTheme(context, 'Lato', 'Dosis'));
    log('Supabase: ${Supabase.instance}');
    return MaterialApp.router(
      title: 'Cantina Fácil',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: authLocalizationsDelegates,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
