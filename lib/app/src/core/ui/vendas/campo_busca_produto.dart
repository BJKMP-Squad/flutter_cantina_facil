import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'venda_cores.dart';

class CampoBuscaProduto extends StatelessWidget {
  const CampoBuscaProduto({
    super.key,
    this.controller,
    this.onChanged,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final borda = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: VendaCores.vendaBorda),
    );

    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      cursorColor: VendaCores.primary,
      style: const TextStyle(
        color: VendaCores.vendaTexto,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintText: 'Buscar por código ou nome',
        hintStyle: const TextStyle(color: VendaCores.vendaTextoSecundario),
        prefixIcon: const Icon(
          Icons.search,
          size: 19,
          color: VendaCores.vendaTextoSecundario,
        ),
        filled: true,
        fillColor: VendaCores.vendaSuperficie,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: borda,
        enabledBorder: borda,
        focusedBorder: borda.copyWith(
          borderSide: const BorderSide(
            color: VendaCores.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

@Preview(group: 'Vendas', name: 'Busca de produto', size: Size(360, 56))
Widget campoBuscaProdutoPreview() => const CampoBuscaProduto();