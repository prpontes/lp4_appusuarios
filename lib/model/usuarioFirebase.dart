class UsuarioFirebase {
  // model usuário
  String? id;
  String? cpf;
  String? nome;
  String? email;
  String? login;
  String? senha;
  String avatar;


  UsuarioFirebase({
    this.id,
    this.cpf,
    this.nome,
    this.email,
    this.login,
    this.senha,
    this.avatar = "",

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

    };
  }

  @override
  String toString() {
    return 'UsuarioFirebase{id: $id, cpf: $cpf, nome: $nome, email: $email, login: $login, senha: $senha, avatar: $avatar}';
  }
}
