import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:lp4_appusuarios/model/usuarioFirebase.dart';

class UsuarioProvider extends ChangeNotifier {
  String nomeTabela = "usuario";

  List<Usuario> usuarios = [];
  List<UsuarioFirebase> usuariosfirebase = [];
  //usuarioEndereco_view

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
    }).then((value) {
      value.collection(u.cpf!).doc("modClientes").set({
        "adicionar": true,
        "deletar": true,
        "editar": true,
        "listar": true,
        "pesquisar": true,
      });
      value.collection(u.cpf!).doc("modUsuarios").set({
        "adicionar": true,
        "deletar": true,
        "editar": true,
        "listar": true,
        "pesquisar": true,
        "detalhe": true,
        "permissoes": true,
      });
      value.collection(u.cpf!).doc("modFornecedores").set({
        "adicionar": true,
        "deletar": true,
        "editar": true,
        "listar": true,
        "pesquisar": true,
      });
      value.collection(u.cpf!).doc("modProdutos").set({
        "adicionar": true,
        "deletar": true,
        "editar": true,
        "listar": true,
        "pesquisar": true,
      });
      value.collection(u.cpf!).doc("modVendas").set({
        "adicionar": true,
        "deletar": true,
        "editar": true,
        "listar": true,
        "pesquisar": true,
      });
    });
    listarUsuarioFirestore();
  }

  listarUsuarioFirestore() async {
    CollectionReference usuarios =
        FirebaseFirestore.instance.collection('usuarios');
    if (this.usuariosfirebase.isNotEmpty) this.usuariosfirebase.clear();

    await usuarios.orderBy('nome').get().then((value) {
      value.docs.forEach((usr) {
        this.usuariosfirebase.add(UsuarioFirebase(
              id: usr.id,
              cpf: usr["cpf"],
              nome: usr["nome"],
              email: usr["email"],
              login: usr["login"],
              senha: usr["senha"],
              avatar: usr["avatar"],
              //telefone: usr["telefone"],
              //isAdmin: usr["isAdmin"],
            ));
      });
    });
    notifyListeners();
    //return usuariosfirebase;
  }

  editarUsuarioFirestore(UsuarioFirebase u) async {
    // var editUsuario = UsuarioFirebase(
    //   id:id,
    //   cpf: cpf,
    //   nome: nome,
    //   email: email,
    //   login: login,
    //   senha: senha,
    //   avatar: avatar,
    // );

    CollectionReference usuarios =
        FirebaseFirestore.instance.collection('usuarios');
    await usuarios.doc(u.id).update({
      "cpf": u.cpf,
      "nome": u.nome,
      "email": u.email,
      "login": u.login,
      "senha": u.senha,
      "avatar": u.avatar,
    });
    await listarUsuarioFirestore();
  }

  deletarUsuarioFirebase(UsuarioFirebase u) async {
    CollectionReference usuarios =
        FirebaseFirestore.instance.collection('usuarios');
    await usuarios.doc(u.id).delete();
    await listarUsuarioFirestore();
  }

  addAuthUsuario(email, password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      var print = '';
      if (e.code == 'weak-password') {
        print = "A senha é muito fraca!";
      } else if (e.code == 'email-already-in-use') {
        print = 'A conta já existe para esse email';
      }
    }
  }
}
