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
      initialRoute: "/",
      routes: {
        "/" : (context) => TelaLogin(), // tela de login
        "/telainicio": (context) => Inicio(),
        "/telausuario" : (context) => TelaUsuario(), // tela de usuário
      },
    ),
  ));
}