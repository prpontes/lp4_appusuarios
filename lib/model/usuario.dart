class Usuario {
  // model usuário
  int? id;
  String? cpf;
  String? nome;
  String? email;
  String? login;
  String? senha;
  String avatar;
  String? telefone;
  bool? isAdmin;

  Usuario({
    this.id,
    this.cpf,
    this.nome,
    this.email,
    this.login,
    this.senha,
    this.avatar = "",
    this.telefone,
    this.isAdmin,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "cpf": cpf,
      "nome": nome,
      "email": email,
      "login": login,
      "senha": senha,
      "avatar": avatar,
      "telefone": telefone,
      "isAdmin": isAdmin,
    };
  }

  @override
  String toString() {
    return 'Usuario{id: $id, cpf: $cpf, nome: $nome, email: $email, login: $login, senha: $senha, avatar: $avatar,telefone: $telefone,isAdmin: $isAdmin}';
  }
}
