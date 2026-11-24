String formatarReais(int centavos) {
  final valor = centavos.abs();
  final inteiro = (valor ~/ 100).toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (_) => '.',
  );
  final decimal = (valor % 100).toString().padLeft(2, '0');
  final sinal = centavos < 0 ? '-' : '';

  return '${sinal}R\$ $inteiro,$decimal';
}