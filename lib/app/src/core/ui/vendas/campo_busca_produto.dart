import 'package:flutter/material.dart';

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
      borderSide: const BorderSide(color: VendaCores.borda),
    );

    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      cursorColor: VendaCores.primario,
      style: const TextStyle(
        color: VendaCores.texto,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintText: 'Buscar por código ou nome',
        hintStyle: const TextStyle(color: VendaCores.textoSecundario),
        prefixIcon: const Icon(
          Icons.search,
          size: 19,
          color: VendaCores.textoSecundario,
        ),
        filled: true,
        fillColor: VendaCores.superficie,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: borda,
        enabledBorder: borda,
        focusedBorder: borda.copyWith(
          borderSide: const BorderSide(
            color: VendaCores.primario,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}