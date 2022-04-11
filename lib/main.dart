import 'package:lp4_appusuarios/api/api.dart';
import 'package:lp4_appusuarios/api/detalhe_album.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:lp4_appusuarios/view/detalhe_usuario.dart';
import 'package:lp4_appusuarios/view/tela_inicio.dart';
import 'package:lp4_appusuarios/view/tela_login.dart';
import 'package:lp4_appusuarios/view/tela_produtos.dart';
import 'package:lp4_appusuarios/view/tela_test.dart';
import 'package:lp4_appusuarios/view/tela_usuario.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var dbProviders = [UsuarioProvider()];

  String dir = join(await getDatabasesPath(), "database.db");

  // delete database
  // await deleteDatabase(dir);
  var database = await openDatabase(dir, onCreate: (db, version) async {
    debugPrint("Database created");
    await Future.wait(dbProviders.map((provider) async {
      await provider.onCreate(db);
    }));
  }, version: 1);

  // Start Providers with database depedency
  await Future.wait(dbProviders.map((provider) async {
    await provider.onInit(database);
  }));

  debugPrint("Database and providers started");

  runApp(
    MultiProvider(
      providers: dbProviders
          .map((provider) =>
              ChangeNotifierProvider(create: (context) => provider))
          .toList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/telateste",
        routes: {
          "/": (context) => const TelaLogin(),
          "/telainicio": (context) => const TelaInicio(),
          "/telausuario": (context) => const TelaUsuario(),
          "/telaapi": (context) => const Api(),
          "/detalhealbum": (context) => const DetalheAlbum(),
          "/detalheusuario": (context) => const TelaDetalheUsuario(),
          "/telaprodutos": (context) => const TelaProdutos(),
          "/telateste": (context) => const TelaTeste(),
        },
      ),
    ),
  );
}
