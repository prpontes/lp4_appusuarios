import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/usuario.dart';
import '../provider/auth_provider.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    Usuario usuarioAutenticado =
        Provider.of<AuthProvider>(context, listen: true).user;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white30,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
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
                          width: 50,
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: "Buscar item do menu",
                          //border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.search))),
                    )
                  ],
                ),
              )),
          const Divider(color: Colors.black26),
          SizedBox(
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/telainicio");
                    },
                    leading: const Icon(
                      Icons.home,
                      color: Colors.blue,
                    ),
                    title: const Text("Início"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.shopping_cart,
                      color: Colors.blue,
                    ),
                    title: const Text("Carrinho"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    title: const Text("Produtos"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.store,
                      color: Colors.blue,
                    ),
                    title: const Text("Fornecedores"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.apartment,
                      color: Colors.blue,
                    ),
                    title: const Text("Clientes"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/telausuario");
                    },
                    leading: const Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: const Text("Usuários"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/telaapi");
                    },
                    leading: const Icon(
                      Icons.api,
                      color: Colors.blue,
                    ),
                    title: const Text("Api"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.settings,
                      color: Colors.blue,
                    ),
                    title: const Text("Configurações"),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.black26),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, "/");
            },
            leading: const Icon(
              Icons.logout,
              color: Colors.blue,
            ),
            title: const Text("Sair"),
          ),
        ],
      ),
    );
  }
}
