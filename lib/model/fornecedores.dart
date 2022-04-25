class Fornecedor {
  // model fornecedor
  int? id;
  String? cnpj;
  String? razaoSocial;
  String? email;
  String? telefone;
  String? login;
  String? senha;
  String? produto;
  int? quantidade;

  Fornecedor({
    this.id,
    this.cnpj,
    this.razaoSocial,
    this.email,
    this.telefone,
    this.login,
    this.senha,
    this.produto,
    this.quantidade,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "cnpj": cnpj,
      "razaoSocial": razaoSocial,
      "email": email,
      "telefone": telefone,
      "login": login,
      "senha": senha,
      "produto": produto,
      "quantidade": quantidade,
    };
  }

  @override
  String toString(){
    return 'Fornecedor{id: $id, cnpj: $cnpj, razaoSocial: $razaoSocial, email: $email, telefone: $telefone, login: $login,'
        'senha: $senha, produto:$produto, quantidade:$quantidade}';
    }
}
