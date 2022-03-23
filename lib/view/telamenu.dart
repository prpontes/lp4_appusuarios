import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
              child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("imagens/img.png"),
              radius: 30,
            ),
            title: Text("Paulo Ricardo"),
            subtitle: Text("prsilvapontes@gmail.com"),
          )),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/");
              },
              child: const ListTile(
                leading: Icon(Icons.home),
                title: Text("Início"),
              )),
          const ListTile(
            leading: Icon(Icons.store),
            title: Text("Fornecedores"),
          ),
          const ListTile(
            leading: Icon(Icons.apartment),
            title: Text("Clientes"),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/telausuario");
            },
            child: const ListTile(
              leading: Icon(Icons.person),
              title: Text("Usuários"),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text("Sair"),
          ),
        ],
      ),
    );
  }
}
