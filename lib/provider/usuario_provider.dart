import 'package:flutter/widgets.dart';
import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:lp4_appusuarios/singletons/database_singleton.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioProvider extends ChangeNotifier {
  Database db = DatabaseSingleton.instance.db;
  String nomeTabela = "usuario";

  List<Usuario> usuarios = [];

  Future<List<Usuario>> getUsuarios() async {
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
    return usuarios;
  }

  consultarLoginUsuario(String login, String senha) async {
    List resultado = await db.query(nomeTabela,
        where: "login = ? and senha = ?", whereArgs: [login, senha]);

    if (resultado.isNotEmpty) {
      return Usuario(
          id: resultado[0]["id"],
          cpf: resultado[0]["cpf"],
          nome: resultado[0]["nome"],
          email: resultado[0]["email"],
          login: resultado[0]["login"],
          senha: resultado[0]["senha"],
          avatar: resultado[0]["avatar"]);
    } else {
      return null;
    }
  }
}
