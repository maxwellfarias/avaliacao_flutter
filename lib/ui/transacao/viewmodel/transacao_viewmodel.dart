import 'package:avaliacao_flutter/model/transacao.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class TransacoesViewModel extends ChangeNotifier{
  // Lista que armazena todas as transações na memória
  final List<Transacao> _transacoes = [];

  // 1. [R] Listagem Completa
  List<Transacao> get transacoes => List.unmodifiable(_transacoes);

  // 2. [C] Cadastro de Transação
  void cadastrar({required String descricao, required double valor, required String tipo, required DateTime data}) {
    try{
      final transacao = Transacao(
        id: const Uuid().v4(),
        descricao: descricao,
        valor: valor,
        tipo: TipoTransacao.fromString(tipo),
        data: data,
      );
      _transacoes.add(transacao);
      notifyListeners();
    } catch (e, s) {
      debugPrint("Erro ao cadastrar transação: $e");
      debugPrint("Stack trace: $s");
    }
  }

  // 3. [U] Atualização de Transação
  void atualizar({required String id, required String novaDescricao, required double novoValor, required String novoTipo}) {
    try{
      final index = _transacoes.indexWhere((item)=> item.id == id);
      if(index == -1) throw Exception("Item não encontrado");
      _transacoes[index] = Transacao(
        id: _transacoes[index].id,
        descricao: novaDescricao,
        valor: novoValor,
        tipo: TipoTransacao.fromString(novoTipo),
        data: DateTime.now(),
      ); 
    } catch (e,s){
      debugPrint("Erro ao cadastrar transação: $e");
      debugPrint("Stack trace: $s");

    }
  }

  // 4. [D] Remoção de Transação
  void remover(String id) {
    try{
      final index = _transacoes.indexWhere((item)=> item.id == id);
      if(index == -1) throw Exception("Item não encontrado");
      _transacoes.removeAt(index); 
    } catch (e,s){
      debugPrint("Erro ao cadastrar transação: $e");
      debugPrint("Stack trace: $s");

    }
  }

  // 5. Cálculos Financeiros (Totais e Saldo)
  double calcularTotalEntradas() {

    // OBJETIVO: Retornar a soma de todas as transações do tipo "entrada".
    // DESAFIO: Como percorrer a lista acumulando apenas os valores que atendem a esse critério?
    return _transacoes.where((item) => item.tipo == TipoTransacao.entrada).toList()
        .fold<double>(0,(previousValue, element) => previousValue + element.valor);
  }

  double calcularTotalSaidas() {
    // OBJETIVO: Retornar a soma de todas as transações do tipo "saida".
    return _transacoes.where((item) => item.tipo == TipoTransacao.saida).toList()
        .fold<double>(0,(previousValue, element) => previousValue + element.valor);;
  }

  double calcularSaldo() {
    // OBJETIVO: Retornar a diferença matemática entre o total de entradas e o total de saídas.
    return calcularTotalEntradas() - calcularTotalSaidas();
  }
}