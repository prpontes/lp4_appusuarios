import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:lp4_appusuarios/model/usuarioFirebase.dart';
import 'package:lp4_appusuarios/singletons/database_singleton.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioProvider extends ChangeNotifier {
  Database db = DatabaseSingleton.instance.db;
  String nomeTabela = "usuario";

  List<Usuario> usuarios = [];
  List<UsuarioFirebase> usuariosfirebase = [];
  //usuarioEndereco_view

  Future<List<Usuario>> listarUsuarios({int? isAdmin}) async {
    List lista = await db.query(nomeTabela,
        where: isAdmin == null ? null : "isAdmin=?",
        whereArgs: isAdmin == null ? null : [isAdmin]);

    usuarios = List.generate(lista.length, (index) {
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
      );
    });

    notifyListeners();
    return usuarios;
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

  addUsuarioFirestore(UsuarioFirebase u) async {
    CollectionReference usuarios =
        FirebaseFirestore.instance.collection('usuarios');
    await usuarios.add({
      'avatar': u.avatar,
      'cpf': u.cpf,
      'email': u.email,
      'login': u.login,
      'nome': u.nome,
      'senha': u.senha,
    });
  }
  listarUsuarioFirestore() async{
    CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');
     if(this.usuariosfirebase.isNotEmpty)
       this.usuariosfirebase.clear();

     await usuarios.orderBy('nome').get().then(
             (value) {
               value.docs.forEach((usr) {
                 this.usuariosfirebase.add(
                   UsuarioFirebase(
                     id: usr.id,
                     cpf: usr["cpf"],
                     nome: usr["nome"],
                     email: usr["email"],
                     login: usr["login"],
                     senha: usr["senha"],
                     avatar: usr["avatar"],
                     //telefone: usr["telefone"],
                     //isAdmin: usr["isAdmin"],
                   )
                 );
               });
             }
     );
    notifyListeners();
    //return usuariosfirebase;
  }

  editarUsuarioFirestore(UsuarioFirebase u) async{
    // var editUsuario = UsuarioFirebase(
    //   id:id,
    //   cpf: cpf,
    //   nome: nome,
    //   email: email,
    //   login: login,
    //   senha: senha,
    //   avatar: avatar,
    // );

    CollectionReference usuarios= FirebaseFirestore.instance.collection('usuarios');
    await usuarios.doc(u.id).update(
      {

          "cpf": u.cpf,
          "nome": u.nome,
          "email": u.email,
          "login": u.login,
          "senha": u.senha,
          "avatar": u.avatar,
      }
    );
    await listarUsuarioFirestore();
  }

  deletarUsuarioFirebase(UsuarioFirebase u) async{
    CollectionReference usuarios= FirebaseFirestore.instance.collection('usuarios');
  await usuarios.doc(u.id).delete();
  await listarUsuarioFirestore();

  }

  Future<int> inserirUsuario(Usuario usuario) async {
    int id = await db.insert(nomeTabela, usuario.toMap());
    usuario.id = id;
    usuarios.add(usuario);
    notifyListeners();
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
