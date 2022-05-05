import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const criarTabelasLista = [
  "CREATE TABLE usuario (id INTEGER PRIMARY KEY AUTOINCREMENT, cpf TEXT, nome TEXT, email TEXT, login TEXT, senha TEXT, avatar TEXT,telefone TEXT, isAdmin INTEGER)",
  "CREATE TABLE fornecedor (id INTEGER PRIMARY KEY AUTOINCREMENT, razaoSocial TEXT, cnpj TEXT, email TEXT, telefone TEXT, imagem TEXT)",
  "CREATE TABLE sell (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, idUser INTEGER, FOREIGN KEY (idUser) REFERENCES usuario(id))",
  "CREATE TABLE itemVenda (id INTEGER PRIMARY KEY AUTOINCREMENT, quantity INTEGER, price REAL, idProduto INTEGER, idVenda INTEGER, FOREIGN KEY(idProduto) REFERENCES product(id), FOREIGN KEY(idVenda) REFERENCES sell(id))",
  "CREATE TABLE product (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, price REAL, image TEXT, quantity INTEGER, idFornecedor INTEGER, FOREIGN KEY(idFornecedor) REFERENCES fornecedor(id))",
];

class DatabaseSingleton {
  DatabaseSingleton._privateConstructor();

  static final DatabaseSingleton _instance =
      DatabaseSingleton._privateConstructor();

  static DatabaseSingleton get instance => _instance;

  late Database db;

  DatabaseSingleton(this.db);

  static Future<DatabaseSingleton> startDatabase() async {
    String dir = join(await getDatabasesPath(), "database.db");

    // delete database
    // await deleteDatabase(dir);

    DatabaseSingleton.instance.db = await openDatabase(
      dir,
      onCreate: (db, version) async {
        for (var sql in criarTabelasLista) {
          await db.execute(sql);
        }
        //  criar usuario admin apenas ao criar o banco
        await db.insert("usuario", {
          "cpf": "12345678910",
          "nome": "Admin",
          "email": "admin@gmail.com",
          "login": "admin",
          "senha": "123456",
          "avatar": "",
          "telefone": "(00)0000-0000",
          "isAdmin": 1
        });
        debugPrint("Database created");
      },
      version: 1,
    );
    return DatabaseSingleton.instance;
  }
}
