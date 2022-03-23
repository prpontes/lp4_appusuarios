import 'package:bd_usuarios/view/inicio.dart';
import 'package:bd_usuarios/view/telausuario.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/": (context) => const Inicio(),
      "/telausuario": (context) => const TelaUsuario(),
    },
  ));
}
