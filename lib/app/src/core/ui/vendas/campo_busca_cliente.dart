import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'venda_cores.dart';

class CampoBuscaCliente extends StatelessWidget {
  const CampoBuscaCliente({super.key, this.controller, this.onChanged});

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    const rotulo = 'Buscar por nome ou matrícula';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: VendaCores.vendaSuperficie,
        border: Border.all(color: VendaCores.vendaBorda),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ExcludeSemantics(
            child: Text(
              rotulo,
              style: TextStyle(
                color: VendaCores.vendaTextoSecundario,
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
              decoration: const InputDecoration(
                hintText: 'Buscar por nome ou matrícula',
              ),
              cursorColor: VendaCores.primary,
              style: TextStyle(color: VendaCores.vendaTexto, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

@Preview(group: 'Vendas', name: 'Busca de cliente', size: Size(360, 88))
Widget campoBuscaClientePreview() => const CampoBuscaCliente();
