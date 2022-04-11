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

  factory Produto.fromJson(Map<String, dynamic> json) => Produto(
        id: json["id"],
        nome: json["nome"],
        descricao: json["descricao"],
        preco: json["preco"].toDouble(),
        imagem: json["imagem"],
        quantidade: json["quantidade"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "descricao": descricao,
        "preco": preco,
        "imagem": imagem,
        "quantidade": quantidade,
      };

  @override
  String toString() {
    return 'Produto{id: $id, nome: $nome, descricao: $descricao, preco: $preco, imagem: $imagem, quantidade: $quantidade}';
  }
}
