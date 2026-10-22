import 'package:avaliacao_flutter/model/transacao.dart';
import 'package:flutter/foundation.dart';

class TransacoesViewModel extends ChangeNotifier{
  // Lista que armazena todas as transações na memória
  final List<Transacao> transacoes = [];

  // Variável para controle de IDs sequenciais automáticos
  int proximoId = 1;

  // 1. [R] Listagem Completa
  List<Transacao> listarTodas() {
    // OBJETIVO: Entregar todas as transações cadastradas até o momento.
    return [];
  }

  // 2. [C] Cadastro de Transação
  void cadastrar(String descricao, double valor, String tipo, DateTime data) {
    // OBJETIVO: Criar uma nova Transacao e guardá-la na lista interna.
    //
    // REGRAS OBRIGATÓRIAS:
    // - O valor não pode ser zero nem negativo.
    // - A descrição não pode estar em branco.
    // - O tipo deve ser padronizado e aceitar apenas "entrada" ou "saida".
    // - O ID deve ser gerado automaticamente sem repetir.
  }

  // 3. [U] Atualização de Transação
  void atualizar(int id, String novaDescricao, double novoValor, String novoTipo) {
    // OBJETIVO: Localizar a transação correspondente ao ID informado e atualizar seus dados.
    // DESAFIO: Como encontrar um item específico dentro da lista para alterar suas propriedades?
  }

  // 4. [D] Remoção de Transação
  void remover(int id) {
    // OBJETIVO: Remover da lista a transação correspondente ao ID recebido.
  }

  // 5. Cálculos Financeiros (Totais e Saldo)
  double calcularTotalEntradas() {
    // OBJETIVO: Retornar a soma de todas as transações do tipo "entrada".
    // DESAFIO: Como percorrer a lista acumulando apenas os valores que atendem a esse critério?
    return 0.0;
  }

  double calcularTotalSaidas() {
    // OBJETIVO: Retornar a soma de todas as transações do tipo "saida".
    return 0.0;
  }

  double calcularSaldo() {
    // OBJETIVO: Retornar a diferença matemática entre o total de entradas e o total de saídas.
    return 0.0;
  }
}