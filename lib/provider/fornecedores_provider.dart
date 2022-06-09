import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lp4_appusuarios/model/fornecedor.dart';
import 'package:lp4_appusuarios/singletons/database_singleton.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

import '../model/fornecedorFirebase.dart';

class FornecedoresProvider extends ChangeNotifier {
  Database db = DatabaseSingleton.instance.db;
  String nomeTabela = "fornecedor";

  List<Fornecedor> fornecedores = [];
  List<FornecedorFirebase> fornecedorfirebase = [];

  addFornecedorFirestore(FornecedorFirebase f) async {
    CollectionReference fornecedores =
        FirebaseFirestore.instance.collection('fornecedores');
    await fornecedores.add({
      'id': f.id,
      'cnpj': f.cnpj,
      'razaoSocial': f.razaoSocial,
      'email': f.email,
      'telefone': f.telefone,
      'imagem': f.imagem,
    });
    // .then((value) {
    //   value.collection(f.cnpj!).doc("modClientes").set({
    //     "adicionar": true,
    //     "deletar": true,
    //     "editar": true,
    //     "listar": true,
    //     "pesquisar": true,
    //   });
    //   value.collection(f.cnpj!).doc("modUsuarios").set({
    //     "adicionar": true,
    //     "deletar": true,
    //     "editar": true,
    //     "listar": true,
    //     "pesquisar": true,
    //     "detalhe": true,
    //     "permissoes": true,
    //   });
    //   value.collection(f.cnpj!).doc("modFornecedores").set({
    //     "adicionar": true,
    //     "deletar": true,
    //     "editar": true,
    //     "listar": true,
    //     "pesquisar": true,
    //   });
    //   value.collection(f.cnpj!).doc("modProdutos").set({
    //     "adicionar": true,
    //     "deletar": true,
    //     "editar": true,
    //     "listar": true,
    //     "pesquisar": true,
    //   });
    //   value.collection(f.cnpj!).doc("modVendas").set({
    //     "adicionar": true,
    //     "deletar": true,
    //     "editar": true,
    //     "listar": true,
    //     "pesquisar": true,
    //   });

    listarFornecedorFirestore();
  }

  listarFornecedorFirestore() async {
    CollectionReference fornecedores =
        FirebaseFirestore.instance.collection('fornecedores');
    if (this.fornecedorfirebase.isNotEmpty) this.fornecedorfirebase.clear();

    await fornecedores.orderBy('razaoSocial').get().then((value) {
      value.docs.forEach((forn) {
        this.fornecedorfirebase.add(FornecedorFirebase(
              id: forn.id,
              cnpj: forn["cnpj"],
              razaoSocial: forn["razaoSocial"],
              email: forn["email"],
              telefone: forn["telefone"],
              imagem: forn["imagem"],
            ));
      });
    });
    notifyListeners();
    //return usuariosfirebase;
  }

  editarFornecedorFirestore(FornecedorFirebase forn) async {
    CollectionReference fornecedores =
        FirebaseFirestore.instance.collection('fornecedores');
    await fornecedores.doc(forn.id).update({
      "cnpj": forn.cnpj,
      "razaoSocial": forn.razaoSocial,
      "email": forn.email,
      "telefone": forn.telefone,
      "imagem": forn.imagem,
    });
    await listarFornecedorFirestore();
  }

  Future<List<Fornecedor>> listarFornecedores() async {
    List lista = await db.query(nomeTabela);

    fornecedores = List.generate(lista.length, (index) {
      return Fornecedor(
          id: lista[index]["id"],
          cnpj: lista[index]["cnpj"],
          razaoSocial: lista[index]["razaoSocial"],
          email: lista[index]["email"],
          telefone: lista[index]["telefone"],
          imagem: lista[index]["imagem"]);
    });
    notifyListeners();
    return fornecedores;
  }

  deletarFornecedorFirestore(FornecedorFirebase forn) async {
    CollectionReference fornecedores =
        FirebaseFirestore.instance.collection('fornecedores');
    await fornecedores.doc(forn.id).delete();
    await listarFornecedorFirestore();
  }

  // Future<Fornecedor?> consultarLoginFornecedor(
  //     String login, String senha) async {
  //   List resultado = await db.query(nomeTabela,
  //       where: "login = ? and senha = ?", whereArgs: [login, senha]);

  //   if (resultado.isNotEmpty) {
  //     return Fornecedor(
  //         id: resultado[0]["id"],
  //         cnpj: resultado[0]["cnpj"],
  //         razaoSocial: resultado[0]["razaoSocial"],
  //         email: resultado[0]["email"],
  //         telefone: resultado[0]["telefone"],);
  //   } else {
  //     return null;
  //   }
  // }

  Future<int> inserirFornecedor(Fornecedor fornecedor) async {
    int id = await db.insert(nomeTabela, fornecedor.toMap());
    fornecedor.id = id;
    fornecedores.add(fornecedor);
    notifyListeners();
    return id;
  }

  Future<int> editarFornecedor(Fornecedor fornecedor) async {
    int id = await db.update(nomeTabela, fornecedor.toMap(),
        where: "id = ?", whereArgs: [fornecedor.id]);
    notifyListeners();
    return id;
  }

  Future<int> deletarFornecedor(Fornecedor fornecedor) async {
    int id = await db
        .delete(nomeTabela, where: "id = ?", whereArgs: [fornecedor.id]);
    fornecedores.remove(fornecedor);
    notifyListeners();
    return id;
  }
}
