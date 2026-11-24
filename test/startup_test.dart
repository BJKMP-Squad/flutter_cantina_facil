import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_cantina_facil/main.dart' as app;

void main() {
  testWidgets('inicialização sem configuração mostra instruções', (
    tester,
  ) async {
    await app.main();
    await tester.pumpAndSettle();

    expect(find.byType(SelectableText), findsOneWidget);
    expect(
      find.textContaining('Configuração de inicialização ausente.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
