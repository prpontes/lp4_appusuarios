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
      return db.execute("CREATE TABLE $tabela(id INTEGER PRIMARY KEY AUTOINCREMENT, cpf TEXT, nome TEXT, email TEXT, login TEXT, senha TEXT, avatar TEXT);"
          "CREATE TABLE modulo(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, ativo INTEGER);"
          "CREATE TABLE $tabela-modulo(id INTEGER PRIMARY KEY AUTOINCREMENT, acessar INTEGER, editar INTEGER, excluir INTEGER, pesquisar INTEGER, idUsuarios INTEGER, idModulo INTEGER, FOREIGN KEY(idUsuarios) REFERENCES $tabela(id), FOREIGN KEY(idModulo) REFERENCES modulo(id);"
          "INSERT INTO modulo(id, nome, ativo) VALUES(1, 'Usuários', 1)");
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
    var db = await this.bd;

    List resultado = await db.query(
        tabela, where: "login = ?", whereArgs: ["admin"]);

    if (resultado.isEmpty) {
      await db.insert(tabela,
          {
            "cpf": "12345678910",
            "nome": "Admin",
            "email": "admin@gmail.com",
            "login": "admin",
            "senha": "123456",
            "avatar": "",
          }
      );
      await db.insert("$tabela-modulo",
          {
            "id": 1,
            "acessar" : 1,
            "editar": 1,
            "excluir": 1,
            "pesquisar": 1,
            "idUsuarios": 1,
            "idModulo" : 1,
          }
      );
    }
  }

  consultarLoginUsuario(String login, String senha) async
  {
    var db = await this.bd;

    List resultado = await db.query(
        tabela, where: "login = ? and senha = ?", whereArgs: [login, senha]);

    if (resultado.isNotEmpty) {
      return Usuario(
          id : resultado[0]["id"],
          cpf: resultado[0]["cpf"],
          nome: resultado[0]["nome"],
          email: resultado[0]["email"],
          login: resultado[0]["login"],
          senha: resultado[0]["senha"],
          avatar: resultado[0]["avatar"]
      );
    } else {
      return null;
    }
  }
}