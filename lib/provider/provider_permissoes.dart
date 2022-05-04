import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lp4_appusuarios/model/permissoes.dart';
import '../model/usuario.dart';

class PermissoesModel extends ChangeNotifier
{
  Usuario? _user;
  Permissoes? _permissoes;

  Usuario get user => _user!;

  set user(Usuario u)
  {
    _user = u;
    notifyListeners();
  }

  Permissoes get permissoes {
    _carregarPermissoesUsuario();
    return _permissoes!;
  }

  set permissoes(Permissoes value) {
    _permissoes = value;
    _definirPermissoesUsuario();

    notifyListeners();
  }

  _definirPermissoesUsuario() async {

    CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');

    await usuarios.doc(user.id).collection(user.cpf!).doc('modClientes').set(_permissoes!.modClientes);
    await usuarios.doc(user.id).collection(user.cpf!).doc('modUsuarios').set(_permissoes!.modUsuarios);
  }

  _carregarPermissoesUsuario() async {
    CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');

    await usuarios.doc(user.id).collection(user.cpf!).get().then(
            (value) {
          value.docs.forEach(
                  (usr) {
                if(usr.id == 'modClientes')
                {
                  _permissoes!.modClientes = {
                    'deletar' : usr['deletar'],
                    'editar' : usr['editar'],
                    'listar' : usr['listar'],
                    'pesquisar' : usr['pesquisar'],
                  };
                }
                if(usr.id == 'modUsuarios')
                {
                  _permissoes!.modUsuarios = {
                    'deletar' : usr['deletar'],
                    'editar' : usr['editar'],
                    'listar' : usr['listar'],
                    'pesquisar' : usr['pesquisar'],
                  };
                }
              }
          );
        }
    );
  }
}