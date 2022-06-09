import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:lp4_appusuarios/model/usuarioFirebase.dart';
import 'package:lp4_appusuarios/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../model/permissoes.dart';
import '../provider/permissoes.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  late AuthProvider authProvider;
  late Permissoes permissoes;
  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    logoutFirebaseAuth() async {
      await FirebaseAuth.instance.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    permissoes = Provider.of<PermissoesModel>(context, listen: true).permissoes;
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
                  UsuarioFirebase usuarioAutenticado = value.user!;
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
                    onTap: () {
                      Navigator.pushNamed(context, "/telacompras");
                    },
                    leading: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.blue,
                    ),
                    title: const Text("Compras"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/productspage");
                    },
                    leading: const Icon(
                      Icons.label_outlined,
                      color: Colors.blue,
                    ),
                    title: const Text("Produtos"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/telafornecedor");
                    },
                    leading: const Icon(
                      Icons.add_business_outlined,
                      color: Colors.blue,
                    ),
                    title: const Text("Fornecedores"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/telacliente");
                    },
                    leading: const Icon(
                      Icons.apartment,
                      color: Colors.blue,
                    ),
                    title: const Text("Clientes"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/telaendereco");
                    },
                    leading: const Icon(
                      Icons.location_on,
                      color: Colors.blue,
                    ),
                    title: const Text("Endereço"),
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
                      if (permissoes.modUsuarios['listar'] == true) {
                        Navigator.pushNamed(context, "/telausuario");
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                              "Você não tem permissão para acessar esse módulo!"),
                        ));
                      }
                    },
                    leading: const Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: const Text("Usuários"),
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
