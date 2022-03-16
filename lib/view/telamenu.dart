import 'package:flutter/material.dart';

class Menu extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("imagens/paulo.jpg"),
                  radius: 30,
                ),
                title: Text("Paulo Ricardo"),
                subtitle: Text("prsilvapontes@gmail.com"),
              )),
          GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, "/");
              },
              child: const ListTile(
                leading: Icon(Icons.home),
                title: Text("Início"),
              )
          ),
          const ListTile(
            leading: Icon(Icons.store),
            title: Text("Fornecedores"),
          ),
          const ListTile(
            leading: Icon(Icons.apartment),
            title: Text("Clientes"),),
          GestureDetector(
            onTap: (){
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