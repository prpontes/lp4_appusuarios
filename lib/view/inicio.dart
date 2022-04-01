import 'package:bd_usuarios/view/telamenu.dart';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Menu(),
        appBar: AppBar(
          title: const Text("Início"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/");
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                  width: 300,
                  height: 100,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.store,
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
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.only(left: 50, top: 10),
                  width: 300,
                  height: 100,
                  child: Row(
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(left: 40, top: 10),
                  width: 300,
                  height: 100,
                  child: Row(
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
                )
              ]),
        ));
  }
}
