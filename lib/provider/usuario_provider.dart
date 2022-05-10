import 'package:flutter/widgets.dart';
import 'package:lp4_appusuarios/model/endereco.dart';
import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:lp4_appusuarios/singletons/database_singleton.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioProvider extends ChangeNotifier {
  Database db = DatabaseSingleton.instance.db;
  String nomeTabela = "usuario";

  List<Usuario> usuarios = [];
  //usuarioEndereco_view
  Future<List<Usuario>> listarUsuariosComEndereco() async {
    List lista = await db.query('usuarioEndereco_view',
        where:  "isAdmin=?",
        whereArgs: [0]);

    usuarios = List.generate(lista.length, (index){
      return Usuario(
        id: lista[index]["id"],
        cpf: lista[index]["cpf"],
        nome: lista[index]["nome"],
        email: lista[index]["email"],
        login: lista[index]["login"],
        senha: lista[index]["senha"],
        avatar: lista[index]["avatar"],
        telefone: lista[index]["telefone"],
        isAdmin: lista[index]["isAdmin"],
        endereco: Endereco(
          idcliente: lista[index]["id"],
          rua: lista[index]["rua"],
          bairro: lista[index]["bairro"],
          numero: lista[index]["numero"],
          cep: lista[index]["cep"],
          cidade: lista[index]["cidade"],
          complemento: lista[index]["complemento"],
          referencia: lista[index]["referencia"],
        ),

      );

    });

    notifyListeners();
    return usuarios;
  }

  Future<List<Usuario>> listarUsuarios({int? isAdmin}) async {
    List lista = await db.query(nomeTabela,
        where: isAdmin == null ? null : "isAdmin=?",
        whereArgs: isAdmin == null ? null : [isAdmin]);

    usuarios = List.generate(lista.length, (index){
      var ender = retornaEndereco(lista, index);
      return Usuario(
        id: lista[index]["id"],
        cpf: lista[index]["cpf"],
        nome: lista[index]["nome"],
        email: lista[index]["email"],
        login: lista[index]["login"],
        senha: lista[index]["senha"],
        avatar: lista[index]["avatar"],
        telefone: lista[index]["telefone"],
        isAdmin: lista[index]["isAdmin"],
        endereco: ender[0],

      );

    });

    notifyListeners();
    return usuarios;
  }

  retornaEndereco(List lista, int i) async {
    var end = await db.query("endereco", where: "idcliente= ?", whereArgs: [lista[i]["id"]]);
    var endereco = List.generate(end.length, (index){
      return Endereco(
        id: lista[index]["id"],
        rua: lista[index]["rua"],
        bairro: lista[index]["bairro"],
        numero: lista[index]["numero"],
        cep: lista[index]["cep"],
        cidade: lista[index]["cidade"],
        complemento: lista[index]["complemento"],
        referencia: lista[index]["referencia"],
      );
    });
    print(endereco);
    return endereco;
  }

  Future<Usuario?> consultarLoginUsuario(String login, String senha) async {
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
        avatar: resultado[0]["avatar"],
        telefone: resultado[0]["telefone"],
        isAdmin: resultado[0]["isAdmin"],
      );
    } else {
      return null;
    }
  }

  Future<int> inserirUsuario(Usuario usuario) async {
    int id = await db.insert(nomeTabela, usuario.toMap());
    usuario.id = id;
    usuarios.add(usuario);
    notifyListeners();
    return id;
  }
  Future<int> inserirEndereco(Usuario usuario) async {
    int id =  await db.insert("endereco", usuario.endereco!.toMap());
    return id;
  }


  Future<int> editarUsuario(Usuario usuario) async {
    int id = await db.update(nomeTabela, usuario.toMap(),
        where: "id = ?", whereArgs: [usuario.id]);
    notifyListeners();
    return id;
  }

  Future<int> deletarUsuario(Usuario usuario) async {
    int id =
        await db.delete(nomeTabela, where: "id = ?", whereArgs: [usuario.id]);
    usuarios.remove(usuario);
    notifyListeners();
    return id;
  }
}
