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
  int isAdmin;
  int? idendereco;

  Usuario({
    this.id,
    this.cpf,
    this.nome,
    this.email,
    this.login,
    this.senha,
    this.avatar = "",
    this.telefone,
    this.isAdmin = 0,
    this.idendereco,
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
      "idendereco": idendereco,
    };
  }

  @override
  String toString() {
    return 'Usuario{id: $id, cpf: $cpf, nome: $nome, email: $email, login: $login, senha: $senha, avatar: $avatar,telefone: $telefone,isAdmin: $isAdmin, idendereco :$idendereco}';
  }
}
