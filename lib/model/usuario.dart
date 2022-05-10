import 'package:lp4_appusuarios/model/endereco.dart';

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
  Endereco? endereco;

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
    this.endereco,
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
