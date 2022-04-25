import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const criarTabelasLista = [
  "CREATE TABLE usuario (id INTEGER PRIMARY KEY AUTOINCREMENT, cpf TEXT, nome TEXT, email TEXT, login TEXT, senha TEXT, avatar TEXT)",
  "CREATE TABLE product (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, price REAL, image TEXT)",
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
    await deleteDatabase(dir);
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
        debugPrint("Database created");
      },
      version: 1,
    );
    return DatabaseSingleton.instance;
  }
}
