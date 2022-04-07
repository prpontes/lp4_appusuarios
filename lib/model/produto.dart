class Produto {
  int? id;
  String nome;
  String? descricao;
  double preco;
  String? imagem;
  int quantidade;

  Produto({
    this.id,
    required this.nome,
    this.descricao,
    this.preco = 0.0,
    this.imagem,
    this.quantidade = 0,
  });
}
