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
                  backgroundImage: AssetImage("imagens/img.png"),
                  radius: 30,
                ),
                title: Text("Paulo Ricardo"),
                subtitle: Text("prsilvapontes@gmail.com"),
              )),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, "/");
            },
            leading: Icon(Icons.home),
            title: Text("Início"),
          ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text("Fornecedores"),
          ),
          ListTile(
            leading: Icon(Icons.apartment),
            title: Text("Clientes"),),

          ListTile(
              onTap: (){
                Navigator.pushNamed(context, "/telausuario");
              },
              leading: Icon(Icons.person),
              title: Text("Usuários"),
            ),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, "/telalogin");
            },
            leading: Icon(Icons.logout),
            title: Text("Sair"),
          ),
        ],
      ),
    );
  }
}