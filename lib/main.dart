import 'package:lp4_appusuarios/provider/auth_provider.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:lp4_appusuarios/singletons/database_singleton.dart';
import 'package:lp4_appusuarios/view/detalhe_usuario.dart';
import 'package:lp4_appusuarios/view/tela_inicio.dart';
import 'package:lp4_appusuarios/view/tela_login.dart';
import 'package:lp4_appusuarios/view/tela_usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o singleton do banco de dados
  await DatabaseSingleton.startDatabase();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UsuarioProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const TelaLogin(),
          "/telainicio": (context) => const TelaInicio(),
          "/telausuario": (context) => const TelaUsuario(),
          "/detalheusuario": (context) => const TelaDetalheUsuario(),
        },
      ),
    ),
  );
}
