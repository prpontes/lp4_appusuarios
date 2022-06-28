import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:lp4_appusuarios/model/permissoes.dart';
import 'package:lp4_appusuarios/model/usuarioFirebase.dart';

class PermissoesModel extends ChangeNotifier {
  Permissoes _permissoes = Permissoes();
  Permissoes get permissoes => _permissoes;

  set permissoes(Permissoes value) {
    _permissoes = value;
    notifyListeners();
  }

  carregarPermissoes(UsuarioFirebase user) async {
    CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');

    await usuarios.doc(user.id).collection(user.cpf!).get().then((value) {
      for (var usr in value.docs) {
        if (usr.id == 'modClientes') {
          permissoes.modClientes = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
          };
        }
        if (usr.id == 'modUsuarios') {
          permissoes.modUsuarios = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
            'detalhe': usr['detalhe'],
            'permissoes': usr['permissoes'],
          };
        }
        if (usr.id == 'modFornecedores') {
          permissoes.modFornecedores = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
          };
        }
        if (usr.id == 'modProdutos') {
          permissoes.modProdutos = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'stock': usr.data()['stock'] ?? false,
            'pesquisar': usr['pesquisar'],
          };
        }
        if (usr.id == 'modVendas') {
          permissoes.modVendas = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
          };
        }
      }
    });
    notifyListeners();
  }
}
