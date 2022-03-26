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
             decoration: BoxDecoration(
               color: Colors.white30,
             ),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("imagens/img.png"),
                  radius: 30,
                ),
                title: const Text("Admin",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
                subtitle: Text("Admin@gmail.com"),
                trailing: Container(
                  padding: EdgeInsets.only(left: 20),
                  width: 40,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.blue,
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                )
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
          Divider(),
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