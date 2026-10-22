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

  const Transacao._({
    required this.id,
    required this.descricao,
    required this.valor,
    required this.tipo,
    required this.data,
  });
  
  factory Transacao.create({
    required String id,
    required String descricao,
    required double valor,
    required TipoTransacao tipo,
    required DateTime data,
  }){
    if(valor <=0){
      throw Exception("O valor deve ser maior que zero.");
    }
    return Transacao._(
      id: id,
      descricao: descricao,
      valor: valor,
      tipo: tipo,
      data: data,
    );
  }
}