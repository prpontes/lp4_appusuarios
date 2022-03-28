import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/usuario.dart';
import '../provider/providerUsuario.dart';

class Menu extends StatefulWidget
{
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  late Usuario usuarioAutenticado;

  @override
  Widget build(BuildContext context) {

    usuarioAutenticado = Provider.of<UsuarioModel>(context, listen: true).user;

    // TODO: implement build
    return Drawer(
      child: ListView(
        children: [
           DrawerHeader(
             decoration: BoxDecoration(
               color: Colors.white30,
             ),
              child: ListTile(
                leading: usuarioAutenticado.avatar! == "" ? Icon(Icons.account_circle, color: Colors.blue,) : CircleAvatar(backgroundImage: NetworkImage(usuarioAutenticado.avatar!), radius: 30,),
                title: Text(usuarioAutenticado.nome!,
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
                subtitle: Text(usuarioAutenticado.email!),
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
              Navigator.pushNamed(context, "/telainicio");
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
              Navigator.pushReplacementNamed(context, "/");
            },
            leading: Icon(Icons.logout),
            title: Text("Sair"),
          ),
        ],
      ),
    );
  }
}