import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:lp4_appusuarios/provider/base_banco_provider.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioProvider extends BaseBancoProvider {
  String nomeTabela = "usuario";

  @override
  onCreate(Database db) async {
    await db.execute(
        "CREATE TABLE $nomeTabela (id INTEGER PRIMARY KEY AUTOINCREMENT, cpf TEXT, nome TEXT, email TEXT, login TEXT, senha TEXT, avatar TEXT)");

    await db.insert("usuario", {
      "cpf": "12345678910",
      "nome": "Admin",
      "email": "admin@gmail.com",
      "login": "admin",
      "senha": "123456",
      "avatar": "",
    });
  }

  @override
  onInit(Database db) {
    this.db = db;
  }

  List<Usuario> usuarios = [];

  getUsuarios() async {
    List lista = await db.query(nomeTabela);

    usuarios = List.generate(lista.length, (index) {
      return Usuario(
        id: lista[index]["id"],
        cpf: lista[index]["cpf"],
        nome: lista[index]["nome"],
        email: lista[index]["email"],
        login: lista[index]["login"],
        senha: lista[index]["senha"],
        avatar: lista[index]["avatar"],
      );
    });
    notifyListeners();
  }

  Future<void> inserirUsuario(Usuario user) async {
    await db.insert(nomeTabela, {
      "cpf": user.cpf,
      "nome": user.nome,
      "email": user.email,
      "login": user.login,
      "senha": user.senha,
      "avatar": user.avatar,
    });
  }
}
