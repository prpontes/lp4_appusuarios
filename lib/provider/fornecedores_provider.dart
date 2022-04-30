import 'package:flutter/widgets.dart';
import 'package:lp4_appusuarios/model/fornecedor.dart';
import 'package:lp4_appusuarios/singletons/database_singleton.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class FornecedoresProvider extends ChangeNotifier {
  Database db = DatabaseSingleton.instance.db;
  String nomeTabela = "fornecedor";

  List<Fornecedor> fornecedores = [];

  FornecedoresProvider() {
    debugPrint("FornecedoresProvider()");
    // listarFornecedores();
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
      );
    });
    notifyListeners();
    return fornecedores;
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
    debugPrint(id.toString());
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
