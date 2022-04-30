import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const criarTabelasLista = [
  "CREATE TABLE usuario (id INTEGER PRIMARY KEY AUTOINCREMENT, cpf TEXT, nome TEXT, email TEXT, login TEXT, senha TEXT, avatar TEXT)",
  "CREATE TABLE fornecedor (id INTEGER PRIMARY KEY AUTOINCREMENT, razaoSocial TEXT, cnpj TEXT, email TEXT, telefone TEXT, imagem TEXT)"
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
        });
        await db.insert("fornecedor", {
          "razaoSocial": "Construtora Dois Irmaos",
          "cnpj": "01022859422",
          "email": "construtoradoisirmaos@gmail.com",
          "telefone": "92319709",
          "imagem": "https://quartaparede.s3.us-east-2.amazonaws.com/wp-content/uploads/2020/03/30221043/Dois-Irmaos.jpg",
        });
        debugPrint("Database created");
      },
      version: 1,
    );
    return DatabaseSingleton.instance;
  }
}
