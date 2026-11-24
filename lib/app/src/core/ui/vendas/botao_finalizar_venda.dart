import 'package:flutter/material.dart';

import 'venda_cores.dart';
import 'venda_moeda.dart';

class BotaoFinalizarVenda extends StatelessWidget {
  const BotaoFinalizarVenda({
    super.key,
    required this.totalEmCentavos,
    required this.onPressed,
    this.isLoading = false,
  });

  final int totalEmCentavos;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: VendaCores.primario,
          foregroundColor: Colors.white,
          disabledBackgroundColor: VendaCores.primario.withAlpha(153),
          disabledForegroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox.square(
          dimension: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
            semanticsLabel: 'Finalizando venda',
          ),
        )
            : Text(
          'Finalizar venda – ${formatarReais(totalEmCentavos)}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}