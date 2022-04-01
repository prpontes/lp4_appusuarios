import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/usuario.dart';
import '../provider/provider_usuario.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late Usuario usuarioAutenticado;

  @override
  Widget build(BuildContext context) {
    usuarioAutenticado = Provider.of<UsuarioModel>(context, listen: true).user;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white30,
              ),
              child: ListTile(
                  leading: usuarioAutenticado.avatar! == ""
                      ? const Icon(
                          Icons.account_circle,
                          color: Colors.blue,
                        )
                      : CircleAvatar(
                          backgroundImage:
                              NetworkImage(usuarioAutenticado.avatar!),
                          radius: 30,
                        ),
                  title: Text(
                    usuarioAutenticado.nome!,
                    style: const TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(usuarioAutenticado.email!),
                  trailing: Container(
                    padding: const EdgeInsets.only(left: 20),
                    width: 40,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ))),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, "/telainicio");
            },
            leading: const Icon(Icons.home),
            title: const Text("Início"),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.store),
            title: const Text("Fornecedores"),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.apartment),
            title: const Text("Clientes"),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, "/telausuario");
            },
            leading: const Icon(Icons.person),
            title: const Text("Usuários"),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, "/");
            },
            leading: const Icon(Icons.logout),
            title: const Text("Sair"),
          ),
        ],
      ),
    );
  }
}
