import 'package:bd_usuarios/view/inicio.dart';
import 'package:bd_usuarios/view/telalogin.dart';
import 'package:bd_usuarios/view/telausuario.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/telalogin",
    routes: {
      "/": (context) => Inicio(),
      "/telalogin" : (context) => TelaLogin(),
      "/telausuario" : (context) => TelaUsuario(),
    },
  ));
}