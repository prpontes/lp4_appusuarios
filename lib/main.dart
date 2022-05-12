import 'package:lp4_appusuarios/components/product/config.dart';
import 'package:lp4_appusuarios/components/shopping_cart_dialog.dart';
import 'package:lp4_appusuarios/provider/auth_provider.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';
import 'package:lp4_appusuarios/provider/fornecedores_provider.dart';
import 'package:lp4_appusuarios/provider/sell_provider.dart';
import 'package:lp4_appusuarios/provider/shopping_cart_provider.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:lp4_appusuarios/singletons/database_singleton.dart';
import 'package:lp4_appusuarios/view/buy_page.dart';
import 'package:lp4_appusuarios/view/config_page.dart';
import 'package:lp4_appusuarios/view/customers_page.dart';
import 'package:lp4_appusuarios/view/home_page.dart';
import 'package:lp4_appusuarios/view/login_page.dart';
import 'package:lp4_appusuarios/view/products_page.dart';
import 'package:lp4_appusuarios/view/providers_page.dart';
import 'package:lp4_appusuarios/view/sell_page.dart';
import 'package:lp4_appusuarios/view/users_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o singleton do banco de dados
  await DatabaseSingleton.startDatabase();
  //DarkThame

  ThemeChanger themeChanger = ThemeChanger();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeChanger>(create: (_) => themeChanger),
      ChangeNotifierProvider(
        create: (_) => UsuarioProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ProductProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => SellProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => FornecedoresProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ShoppingCartProvider(),
      ),
    ],
    child: Builder(builder: (context) {
      var isDark = Provider.of<ThemeChanger>(context, listen: true).isDark;
      return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.purple[200],
        ),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blueGrey,
            accentColor: Colors.purpleAccent,
            appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple)),
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const TelaLogin(),
          "/telainicio": (context) => const TelaInicio(),
          "/telausuario": (context) => const TelaUsuario(),
          "/productspage": (context) => const ProductsPage(),
          "/telafornecedor": (context) => const TelaFornecedor(),
          "/telavendas": (context) => const TelaVendas(),
          "/telacliente": (context) => const TelaCliente(),
          "/telacarrinho": (context) => const ShoppingCartDialog(),
          "/telacompras": (context) => const BuyPage(),
          "/telaconfig": (context) => const config_page(),
        },
      );
    }),
  ));
}
