class Fornecedor {
  // model fornecedor
  String? id;
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
    this.imagem = "",
  });

  Map<String, dynamic> toMap() {
    return {
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
