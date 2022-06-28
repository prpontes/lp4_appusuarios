import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lp4_appusuarios/components/shopping_cart_dialog.dart';
// import 'package:lp4_appusuarios/components/shopping_cart_dialog.dart';
import 'package:lp4_appusuarios/provider/auth_provider.dart';
import 'package:lp4_appusuarios/provider/endereco_provider.dart';
import 'package:lp4_appusuarios/provider/permissoes.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';
import 'package:lp4_appusuarios/provider/fornecedores_provider.dart';
import 'package:lp4_appusuarios/provider/sell_provider.dart';
// import 'package:lp4_appusuarios/provider/sell_provider.dart';
import 'package:lp4_appusuarios/provider/shopping_cart_provider.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:lp4_appusuarios/view/address_page.dart';
import 'package:lp4_appusuarios/view/buy_page.dart';
// import 'package:lp4_appusuarios/view/buy_page.dart';
import 'package:lp4_appusuarios/view/customers_page.dart';
import 'package:lp4_appusuarios/view/home_page.dart';
import 'package:lp4_appusuarios/view/login_page.dart';
import 'package:lp4_appusuarios/view/products_page.dart';
import 'package:lp4_appusuarios/view/providers_page.dart';
import 'package:lp4_appusuarios/view/sell_page.dart';
// import 'package:lp4_appusuarios/view/sell_page.dart';
import 'package:lp4_appusuarios/view/users_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    // name: 'lp4_appusuarios',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final UsuarioProvider usuarioProvider = UsuarioProvider();
  final AuthProvider authProvider =
      AuthProvider(usuarioProvider: usuarioProvider);
  final PermissoesModel permissoesProvider = PermissoesModel();

  if (FirebaseAuth.instance.currentUser != null) {
    await authProvider.login(FirebaseAuth.instance.currentUser);
    await permissoesProvider.carregarPermissoes(authProvider.user!);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => usuarioProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => authProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EnderecoProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FornecedoresProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ShoppingCartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => permissoesProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => SellProvider(
            productProvider: Provider.of(context, listen: false),
            usuarioProvider: Provider.of(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.dark().copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.deepPurple, secondary: Colors.deepPurpleAccent),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute:
            FirebaseAuth.instance.currentUser != null ? "/home" : "/login",
        routes: {
          "/login": (context) => const TelaLogin(),
          "/home": (context) => const TelaInicio(),
          "/telausuario": (context) => const TelaUsuario(),
          "/productspage": (context) => const ProductsPage(),
          "/telafornecedor": (context) => const TelaFornecedor(),
          "/telavendas": (context) => const TelaVendas(),
          "/telacliente": (context) => const TelaCliente(),
          "/telacarrinho": (context) => const ShoppingCartDialog(),
          "/telacompras": (context) => const BuyPage(),
          "/telaendereco": (context) => const TelaEndereco(),
        },
      ),
    ),
  );
}
