import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lp4_appusuarios/model/fornecedor.dart';
import 'package:flutter/material.dart';

import '../model/fornecedorFirebase.dart';

class FornecedoresProvider extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
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
    var query = (await db.collection(nomeTabela).get()).docs;

    fornecedores = List.generate(query.length, (index) {
      return Fornecedor(
          id: query[index].id,
          cnpj: query[index]["cnpj"],
          razaoSocial: query[index]["razaoSocial"],
          email: query[index]["email"],
          telefone: query[index]["telefone"],
          imagem: query[index]["imagem"]);
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

  Future<String?> inserirFornecedor(Fornecedor fornecedor) async {

    try{
      DocumentReference<Map<String, dynamic>> document = await db.collection(nomeTabela).add(fornecedor.toMap());
      fornecedor.id = document.id;
      fornecedores.add(fornecedor);
      notifyListeners();
      return fornecedor.id;
    }catch (e){
      return null;
    }
  }

  Future<bool> editarFornecedor(Fornecedor fornecedor) async {
    try {
      await db.collection(nomeTabela).doc(fornecedor.id!).update(fornecedor.toMap());
      await listarFornecedores();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletarFornecedor(Fornecedor fornecedor) async {

    try {
      await db.collection(nomeTabela).doc(fornecedor.id).delete();
      await listarFornecedores();
      fornecedores.remove(fornecedor);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
