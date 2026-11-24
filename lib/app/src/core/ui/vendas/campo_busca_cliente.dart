import 'package:flutter/material.dart';

import 'venda_cores.dart';

class CampoBuscaCliente extends StatelessWidget {
  const CampoBuscaCliente({
    super.key,
    this.controller,
    this.onChanged,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    const rotulo = 'Buscar por nome ou matrícula';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: VendaCores.superficie,
        border: Border.all(color: VendaCores.borda),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ExcludeSemantics(
            child: Text(
              rotulo,
              style: TextStyle(
                color: VendaCores.textoSecundario,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Semantics(
            label: rotulo,
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              textInputAction: TextInputAction.search,
              cursorColor: VendaCores.primario,
              style: const TextStyle(
                color: VendaCores.texto,
                fontSize: 16,
              ),
              decoration: const InputDecoration.collapsed(
                hintText: '',
                filled: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}