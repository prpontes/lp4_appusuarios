import 'package:lp4_appusuarios/api/api.dart';
import 'package:lp4_appusuarios/api/detalhe_album.dart';
import 'package:lp4_appusuarios/provider/provider_usuario.dart';
import 'package:lp4_appusuarios/view/detalhe_usuario.dart';
import 'package:lp4_appusuarios/view/tela_inicio.dart';
import 'package:lp4_appusuarios/view/tela_login.dart';
import 'package:lp4_appusuarios/view/tela_produtos.dart';
import 'package:lp4_appusuarios/view/tela_usuario.dart';
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
          "/": (context) => const TelaLogin(),
          "/telainicio": (context) => const TelaInicio(),
          "/telausuario": (context) => const TelaUsuario(),
          "/telaapi": (context) => const Api(),
          "/detalhealbum": (context) => const DetalheAlbum(),
          "/detalheusuario": (context) => const TelaDetalheUsuario(),
          "/telaprodutos": (context) => const TelaProdutos(),
        },
      ),
    ),
  );
}
