class Fornecedor {
  // model fornecedor
  int? id;
  String? cnpj;
  String? razaoSocial;
  String? email;
  String? telefone;
  String imagem;

  Fornecedor({
    this.id,
    this.cnpj,
    this.razaoSocial,
    this.email,
    this.telefone,
    this.imagem ="", //TODO Se não inicializar, dá erro. Se inicializar, qualquer imagem adicionada depois, volta pro estágio vazio, quando atualizado.
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "cnpj": cnpj,
      "razaoSocial": razaoSocial,
      "email": email,
      "telefone": telefone,
      "imagem": imagem,
    };
  }

  @override
  String toString() {
    return 'Fornecedor{id: $id, razaoSocial: $razaoSocial, cnpj: $cnpj, , email: $email, telefone: $telefone, imagem:$imagem}';
  }
}
