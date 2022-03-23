import 'package:bd_usuarios/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class Banco {
  String tabela = "usuarios";
  Database? _bd;

  Future<Database> get bd async {
    if (_bd != null) {
      return _bd!;
    } else {
      _bd = await abrirBanco();
    }

    return _bd!;
  }

  Future<Database> abrirBanco() async {
    String dir = await getDatabasesPath();
    var bd = await openDatabase(join(dir, "bduser.db"), onCreate: (db, versao) {
      return db.execute(
          "CREATE TABLE $tabela(id INTEGER PRIMARY KEY AUTOINCREMENT, cpf TEXT, nome TEXT, email TEXT)");
    }, version: 1);
    return bd;
  }

  Future<void> inserirUsuario(Usuario user) async {
    var bd = await this.bd;
    int resultado = await bd.insert(
        tabela, {"cpf": user.cpf, "nome": user.nome, "email": user.email});
    debugPrint("Resultado: $resultado");
  }

  Future<List<Usuario>> listarUsuarios() async {
    var bd = await this.bd;
    List lista = await bd.query(tabela);

    return List.generate(lista.length, (index) {
      return Usuario(
          id: lista[index]["id"],
          cpf: lista[index]["cpf"],
          nome: lista[index]["nome"],
          email: lista[index]["email"]);
    });
  }

  editarUsuario(Usuario user) async {
    var db = await bd;
    db.update(tabela, {"cpf": user.cpf, "nome": user.nome, "email": user.email},
        where: "id = ?", whereArgs: [user.id]);
  }

  Future<void> deletarUsuario(int id) async {
    var db = await bd;
    db.delete(tabela, where: "id = ?", whereArgs: [id]);
  }
}
