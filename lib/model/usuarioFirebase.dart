class UsuarioFirebase {
  // model usuário
  String? id;
  String? cpf;
  String? nome;
  String? email;
  String? login;
  String? senha;
  String telefone;
  String avatar;
  bool isCliente;

  UsuarioFirebase({
    this.id,
    this.cpf,
    this.nome,
    this.email,
    this.login,
    this.senha,
    this.avatar = "",
    this.telefone = "",
    this.isCliente = false,
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
      "isCliente": isCliente,
    };
  }

  factory UsuarioFirebase.fromMap(String id, Map<String, dynamic> map) {
    return UsuarioFirebase(
      id: id,
      cpf: map["cpf"],
      nome: map["nome"],
      email: map["email"],
      login: map["login"],
      senha: map["senha"],
      avatar: map["avatar"],
      telefone: map["telefone"] ?? "",
      isCliente: map["isCliente"] ?? false,
    );
  }

  @override
  String toString() {
    return 'UsuarioFirebase{id: $id, cpf: $cpf, nome: $nome, email: $email, login: $login, senha: $senha, avatar: $avatar, telefone $telefone, isCliente $isCliente}';
  }
}
