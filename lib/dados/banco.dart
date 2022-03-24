import 'package:bd_usuarios/model/usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class Banco{

  String tabela = "usuarios";
  Database? _bd;

  Future<Database> get bd async{
    if(_bd != null){
      return _bd!;
    }else{
      _bd = await abrirBanco();
    }

    return _bd!;
  }

  Future<Database> abrirBanco() async{
    String dir = await getDatabasesPath();
    var bd = await openDatabase(join(dir, "bduser.db"), onCreate: (db, versao){
      return db.execute("CREATE TABLE $tabela(id INTEGER PRIMARY KEY AUTOINCREMENT, cpf TEXT, nome TEXT, email TEXT, login TEXT, senha TEXT, avatar TEXT)");
    },
      version: 1
    );
    return bd;
  }

  Future<void> inserirUsuario(Usuario user) async {

    var bd = await this.bd;
    int resultado = await bd.insert(tabela,
      {
        "cpf": user.cpf,
        "nome": user.nome,
        "email": user.email,
        "login": user.login,
        "senha": user.senha,
        "avatar": user.avatar,
      }
    );
    print("$resultado inserido com sucesso!");
  }

  Future<List<Usuario>> listarUsuarios() async {

    var bd = await this.bd;
    List lista = await bd.query(tabela);

    return List.generate(lista.length,
      (index){
        return Usuario(
            id: lista[index]["id"],
            cpf: lista[index]["cpf"],
            nome: lista[index]["nome"],
            email: lista[index]["email"],
            login: lista[index]["login"],
            senha: lista[index]["senha"],
            avatar: lista[index]["avatar"],
        );
      }
    );
  }

  editarUsuario(Usuario user) async
  {
    var db = await this.bd;
    db.update(
      tabela,
      {
        "cpf":user.cpf,
        "nome":user.nome,
        "email":user.email,
        "login":user.login,
        "senha":user.senha,
        "avatar":user.avatar,
      },
      where: "id = ?",
      whereArgs: [user.id]
    );
  }

  Future<void> deletarUsuario(int id) async
  {
    var db = await this.bd;
    db.delete(tabela, where: "id = ?", whereArgs: [id]);
  }

  criarUsuarioAdmin() async
  {
    var bd = await this.bd;
    int resultado = await bd.insert(tabela,
        {
          "cpf": "12345678910",
          "nome": "Admin",
          "email": "admin@gmail.com",
          "login": "admin",
          "senha": "123456",
          "avatar": "",
        }
    );
  }

  Future<bool> consultarUsuario(String login, String senha) async
  {
    var db = await this.bd;

    List resultado = await db.query(
        tabela, where: "login = ? and senha = ?", whereArgs: [login, senha]);

    print(resultado);
    if (resultado.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}