import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../model/fornecedorFirebase.dart';

class FornecedoresProvider extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String nomeTabela = "fornecedor";

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
    if (fornecedorfirebase.isNotEmpty) fornecedorfirebase.clear();

    await fornecedores.orderBy('razaoSocial').get().then((value) {
      for (var forn in value.docs) {
        fornecedorfirebase.add(FornecedorFirebase(
          id: forn.id,
          cnpj: forn["cnpj"],
          razaoSocial: forn["razaoSocial"],
          email: forn["email"],
          telefone: forn["telefone"],
          imagem: forn["imagem"],
        ));
      }
    });
    notifyListeners();
    return fornecedorfirebase;
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

}
