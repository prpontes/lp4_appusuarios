import 'package:lp4_appusuarios/view/tela_menu.dart';
import 'package:flutter/material.dart';

class TelaInicio extends StatefulWidget {
  const TelaInicio({Key? key}) : super(key: key);

  @override
  State<TelaInicio> createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Menu(),
        appBar: AppBar(
          title: const Text("Início"),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings)
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/");
                },
                icon: const Icon(Icons.logout)
            )
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
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/telausuario");
                  },
                  child: Container(
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
                  ),
                )
              ]),
        ));
  }
}
