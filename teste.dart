class Produto {
  int id;
  String nome;
  double preco;
  String description;
  int quantidade = 0;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.description,
    required this.quantidade,
  });
}

class Carrinho {
  List<Produto> produtos = [];
}
