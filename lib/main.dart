import 'package:bd_usuarios/provider/providerUsuario.dart';
import 'package:bd_usuarios/view/inicio.dart';
import 'package:bd_usuarios/view/telalogin.dart';
import 'package:bd_usuarios/view/telausuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => UsuarioModel(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/telalogin",
      routes: {
        "/": (context) => Inicio(),
        "/telalogin" : (context) => TelaLogin(), // tela de login
        "/telausuario" : (context) => TelaUsuario(), // tela de usuário
      },
    ),
  ));
}