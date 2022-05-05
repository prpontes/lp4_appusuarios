import 'package:lp4_appusuarios/components/details_user_dialog.dart';
import 'package:lp4_appusuarios/components/mutate_user_dialog.dart';
import 'package:lp4_appusuarios/components/search_user_delegate.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:provider/provider.dart';

class TelaUsuario extends StatefulWidget {
  const TelaUsuario({Key? key}) : super(key: key);

  @override
  State<TelaUsuario> createState() => _TelaUsuarioState();
}

class _TelaUsuarioState extends State<TelaUsuario> {
  late UsuarioProvider usuarioProvider;

  @override
  void initState() {
    super.initState();
    usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
    usuarioProvider.listarUsuarios(isAdmin: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de usuários"),
        // input Search bar on changed
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate:
                    SearchUserDelegate(usuarios: usuarioProvider.usuarios),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<UsuarioProvider>(
              builder: (BuildContext context, value, Widget? child) {
                final usuarios = value.usuarios;
                return ListView.builder(
                  itemCount: usuarios.length,
                  itemBuilder: (context, index) {
                    if (usuarios.isNotEmpty == true) {
                      final usuario = usuarios[index];
                      return Card(
                        child: ListTile(
                          leading: usuario.avatar == ""
                              ? const Icon(
                                  Icons.account_circle,
                                  color: Colors.blue,
                                  size: 50,
                                )
                              : SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      usuario.avatar,
                                    ),
                                  ),
                                ),
                          title: Text(usuario.nome!),
                          subtitle: Text(usuario.email!),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DetailsUserDialog(
                                  usuario: usuario,
                                ),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Text("nenhum usuário");
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const MutateUserDialog(),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
