import 'package:avaliacao_flutter/model/transacao.dart';
import 'package:avaliacao_flutter/ui/transacao/viewmodel/transacao_viewmodel.dart';
import 'package:flutter/material.dart';

/// Formulário em bottom sheet usado para cadastrar ou editar uma transação.
/// Quando [transacao] é informada, o formulário funciona em modo de edição.
final class TransacaoForm extends StatefulWidget {
  final TransacoesViewModel viewModel;
  final Transacao? transacao;

  const TransacaoForm({super.key, required this.viewModel, this.transacao});

  @override
  State<TransacaoForm> createState() => _TransacaoFormState();
}

class _TransacaoFormState extends State<TransacaoForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _descricaoController;
  late final TextEditingController _valorController;
  late TipoTransacao _tipo;

  bool get _editando => widget.transacao != null;

  @override
  void initState() {
    super.initState();
    final transacao = widget.transacao;
    _descricaoController = TextEditingController(text: transacao?.descricao);
    _valorController = TextEditingController(
      text: transacao?.valor.toStringAsFixed(2).replaceAll('.', ','),
    );
    _tipo = transacao?.tipo ?? TipoTransacao.entrada;
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  double? _parseValor(String? text) =>
      double.tryParse((text ?? '').trim().replaceAll(',', '.'));

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;
    final descricao = _descricaoController.text.trim();
    final valor = _parseValor(_valorController.text)!;

    if (_editando) {
      widget.viewModel.atualizar(
        id: widget.transacao!.id,
        novaDescricao: descricao,
        novoValor: valor,
        novoTipo: _tipo.name,
      );
    } else {
      widget.viewModel.cadastrar(
        descricao: descricao,
        valor: valor,
        tipo: _tipo.name,
        data: DateTime.now(),
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _editando ? "Editar transação" : "Nova transação",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: "Descrição"),
              textCapitalization: TextCapitalization.sentences,
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? "A descrição não pode ser vazia."
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _valorController,
              decoration: const InputDecoration(
                labelText: "Valor",
                prefixText: "R\$ ",
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                final valor = _parseValor(value);
                if (valor == null || valor <= 0) {
                  return "Informe um valor maior que zero.";
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            SegmentedButton<TipoTransacao>(
              segments: const [
                ButtonSegment(
                  value: TipoTransacao.entrada,
                  label: Text("Entrada"),
                  icon: Icon(Icons.arrow_downward),
                ),
                ButtonSegment(
                  value: TipoTransacao.saida,
                  label: Text("Saída"),
                  icon: Icon(Icons.arrow_upward),
                ),
              ],
              selected: {_tipo},
              onSelectionChanged: (selecao) =>
                  setState(() => _tipo = selecao.first),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _salvar,
              child: Text(_editando ? "Salvar" : "Adicionar"),
            ),
          ],
        ),
      ),
    );
  }
}
