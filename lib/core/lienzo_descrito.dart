import 'package:flutter/material.dart';

// Envoltura comun para las graficas documentadas.
// Muestra la grafica arriba y, debajo, una tarjeta con dos campos:
// para que sirve y en que caso conviene usarla.
class LienzoDescrito extends StatelessWidget {
  final String titulo;
  final String paraQue;
  final String cuando;
  final Widget grafica;

  const LienzoDescrito({
    super.key,
    required this.titulo,
    required this.paraQue,
    required this.cuando,
    required this.grafica,
  });

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Column(
        children: [
          Expanded(
            child: Padding(padding: const EdgeInsets.all(16), child: grafica),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: esquema.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _Campo(
                  icono: Icons.lightbulb_outline,
                  etiqueta: 'Para que sirve',
                  texto: paraQue,
                  color: esquema.primary,
                ),
                const SizedBox(height: 10),
                _Campo(
                  icono: Icons.check_circle_outline,
                  etiqueta: 'Cuando usarla',
                  texto: cuando,
                  color: esquema.tertiary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Campo extends StatelessWidget {
  final IconData icono;
  final String etiqueta;
  final String texto;
  final Color color;

  const _Campo({
    required this.icono,
    required this.etiqueta,
    required this.texto,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icono, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                etiqueta,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 2),
              Text(texto, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}