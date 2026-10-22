import 'package:flutter/material.dart';

/// Cards com o total de entradas, total de saídas e saldo.
final class TransacaoResumo extends StatelessWidget {
  final double totalEntradas;
  final double totalSaidas;
  final double saldo;

  const TransacaoResumo({
    super.key,
    required this.totalEntradas,
    required this.totalSaidas,
    required this.saldo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: _ResumoCard(
              titulo: "Entradas",
              valor: totalEntradas,
              cor: Colors.green,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _ResumoCard(
              titulo: "Saídas",
              valor: totalSaidas,
              cor: Colors.red,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _ResumoCard(
              titulo: "Saldo",
              valor: saldo,
              cor: saldo < 0 ? Colors.red : Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

final class _ResumoCard extends StatelessWidget {
  final String titulo;
  final double valor;
  final Color cor;

  const _ResumoCard({
    required this.titulo,
    required this.valor,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          children: [
            Text(titulo, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "R\$ ${valor.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: cor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
