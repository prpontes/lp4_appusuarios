import 'package:lp4_appusuarios/components/badge.dart';
import 'package:lp4_appusuarios/components/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/components/shopping_cart_dialog.dart';
import 'package:lp4_appusuarios/provider/shopping_cart_provider.dart';
import 'package:provider/provider.dart';

class TelaInicio extends StatefulWidget {
  const TelaInicio({Key? key}) : super(key: key);

  @override
  State<TelaInicio> createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const HomeDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const ShoppingCartDialog(),
                fullscreenDialog: true,
              ),
            );
          },
          // show shopping cart icon with a badge
          child: Consumer<ShoppingCartProvider>(
            builder: (context, value, child) {
              var shoppingCartProvider = value;
              var total = shoppingCartProvider.totalItems;
              return Badge(
                child: child!,
                value: total.toString(),
                right: 0,
                top: 0,
              );
            },
            child: Icon(
              Icons.shopping_cart,
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text("Início usuário"),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 300,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/telafornecedor");
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.pinkAccent),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add_business_outlined,
                          size: 50,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Fornecedores",
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/telacliente");
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.apartment,
                          size: 50,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Clientes",
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/telausuario");
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.person,
                          size: 50,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Usuários",
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
        ));
  }
}
