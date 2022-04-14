import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:lp4_appusuarios/api/api.dart';
import 'package:lp4_appusuarios/api/detalhe_album.dart';
import 'package:lp4_appusuarios/provider/provider_usuario.dart';
import 'package:lp4_appusuarios/services/auth_service.dart';
import 'package:lp4_appusuarios/view/AuthCheck.dart';
import 'package:lp4_appusuarios/view/detalhe_usuario.dart';
import 'package:lp4_appusuarios/view/tela_inicio.dart';
import 'package:lp4_appusuarios/view/tela_login.dart';
import 'package:lp4_appusuarios/view/tela_usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => UsuarioModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          //"/": (context) => const AuthCheck(),
          "/": (context) => const TelaLogin(),
          "/telainicio": (context) => const TelaInicio(),
          "/telausuario": (context) => const TelaUsuario(),
          "/telaapi":(context) => const Api(),
          "/detalhealbum" : (context) => const DetalheAlbum(),
          "/detalheusuario" : (context) => const TelaDetalheUsuario(),
        },
      ),
    ),
  );
}
