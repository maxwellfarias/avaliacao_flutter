import 'package:avaliacao_flutter/model/transacao.dart';
import 'package:avaliacao_flutter/ui/transacao/viewmodel/transacao_viewmodel.dart';
import 'package:avaliacao_flutter/ui/transacao/widgets/transacao_form.dart';
import 'package:avaliacao_flutter/ui/transacao/widgets/transacao_resumo.dart';
import 'package:flutter/material.dart';

final class TransacaoView extends StatelessWidget {
  final TransacoesViewModel viewModel;

  const TransacaoView({super.key, required this.viewModel});

  void _abrirFormulario(BuildContext context, {Transacao? transacao}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) =>
          TransacaoForm(viewModel: viewModel, transacao: transacao),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerenciamento de Transações"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormulario(context),
        child: const Icon(Icons.add),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          final transacoes = viewModel.transacoes;
          return Column(
            children: [
              TransacaoResumo(
                totalEntradas: viewModel.calcularTotalEntradas(),
                totalSaidas: viewModel.calcularTotalSaidas(),
                saldo: viewModel.calcularSaldo(),
              ),
              Expanded(child: _buildLista(context, transacoes)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLista(BuildContext context, List<Transacao> transacoes) {
    if (transacoes.isEmpty) {
      return const Center(child: Text("Nenhuma transação cadastrada."));
    }
    return ListView.builder(
      itemCount: transacoes.length,
      itemBuilder: (context, index) {
        final transacao = transacoes[index];
        final isEntrada = transacao.tipo == TipoTransacao.entrada;
        return ListTile(
          onTap: () => _abrirFormulario(context, transacao: transacao),
          leading: Icon(
            isEntrada ? Icons.arrow_downward : Icons.arrow_upward,
            color: isEntrada ? Colors.green : Colors.red,
          ),
          title: Text(transacao.descricao),
          subtitle: Text(
            "${transacao.data.day.toString().padLeft(2, '0')}/"
            "${transacao.data.month.toString().padLeft(2, '0')}/"
            "${transacao.data.year}",
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${isEntrada ? '+' : '-'} R\$ ${transacao.valor.toStringAsFixed(2)}",
                style: TextStyle(color: isEntrada ? Colors.green : Colors.red),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: "Remover",
                onPressed: () => viewModel.remover(transacao.id),
              ),
            ],
          ),
        );
      },
    );
  }
}
