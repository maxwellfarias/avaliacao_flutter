enum TipoTransacao{
  entrada,
  saida
}

final class Transacao {
  final String id;           // Identificador único sequencial (1, 2, 3...)
  final String descricao; // Ex: "Salário", "Lanche", "Uber"
  final double valor;     // Sempre um valor positivo (Ex: 35.50)
  final TipoTransacao tipo;      // Deve ser exatamente "entrada" ou "saida"
  final DateTime data;    // Data da realização da transação

  Transacao({
    required this.id,
    required this.descricao,
    required this.valor,
    required this.tipo,
    required this.data,
  }){
    if(valor <= 0){
      throw Exception("O valor deve ser maior que zero.");
    }
    if(descricao.isEmpty){
      throw Exception("A descrição não pode ser vazia.");
    }
    if(data.isAfter(DateTime.now())){
      throw Exception("A data não pode ser maior que a data atual.");
    }
  }
}