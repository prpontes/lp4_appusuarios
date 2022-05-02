import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:lp4_appusuarios/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  late AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        // screen height
        height: 900,
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Consumer<AuthProvider>(builder: (context, value, child) {
                  if (!value.isLoggedIn) {
                    return const CircularProgressIndicator();
                  }
                  Usuario usuarioAutenticado = value.user!;
                  return ListTile(
                    leading: usuarioAutenticado.avatar == ""
                        ? const Icon(
                            Icons.account_circle,
                            color: Colors.blue,
                            size: 30,
                          )
                        : SizedBox(
                            width: 30,
                            height: 30,
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(usuarioAutenticado.avatar),
                              radius: 30,
                            ),
                          ),
                    title: Text(
                      usuarioAutenticado.nome!,
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(usuarioAutenticado.email!),
                    trailing: IconButton(
                      tooltip: "Sair",
                      onPressed: () {
                        authProvider.logout();
                        Navigator.pushReplacementNamed(context, "/");
                      },
                      icon: const Icon(Icons.logout),
                    ),
                  );
                }),
              ),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
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
                      Navigator.pushNamed(context, "/telavendas");
                    },
                    leading: const Icon(
                      Icons.monetization_on,
                      color: Colors.blue,
                    ),
                    title: const Text("Vendas"),
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
                      Navigator.pushNamed(context, "/telavendas");
 
                    },
                    leading: const Icon(
                      Icons.monetization_on,
                      color: Colors.blue,
                    ),
                    title: const Text("Vendas"),
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
          ],
        ),
      ),
    );
  }
}
