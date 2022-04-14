class Usuario {
  // model usuário
  int? id;
  String? cpf;
  String? nome;
  String? email;
  String? login;
  String? senha;
  String? avatar;

  Usuario({
    this.id,
    this.cpf,
    this.nome,
    this.email,
    this.login,
    this.senha,
    this.avatar,
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
}
