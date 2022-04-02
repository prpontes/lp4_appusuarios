import 'package:bd_usuarios/api/api.dart';
import 'package:bd_usuarios/provider/provider_usuario.dart';
import 'package:bd_usuarios/view/inicio.dart';
import 'package:bd_usuarios/view/telalogin.dart';
import 'package:bd_usuarios/view/telausuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UsuarioModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const TelaLogin(), // tela de login
          "/telainicio": (context) => const Inicio(),
          "/telausuario": (context) => const TelaUsuario(), // tela de usuário
          "/api":(context) => const Api(),
        },
      ),
    ),
  );
}
