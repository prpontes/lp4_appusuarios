import 'package:lp4_appusuarios/components/create_user_dialog.dart';
import 'package:lp4_appusuarios/components/details_user_dialog.dart';
import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:provider/provider.dart';
import 'package:diacritic/diacritic.dart';

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
    usuarioProvider.listarUsuarios();
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
                delegate: UserSearch(usuarios: usuarioProvider.usuarios),
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
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    usuario.avatar!,
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
              builder: (BuildContext context) => const CreateUserDialog(),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserSearch extends SearchDelegate<String> {
  List<Usuario> usuarios;

  UserSearch({required this.usuarios})
      : super(searchFieldLabel: "Buscar usuários");

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listaUsuarios = query.isEmpty
        ? usuarios
        : usuarios
            .where(
              (p) =>
                  removeDiacritics(p.nome!.toLowerCase())
                      .contains(removeDiacritics(query.toLowerCase())) ||
                  p.email!.toLowerCase().contains(query.toLowerCase()) ||
                  p.login!.toLowerCase().contains(query.toLowerCase()) ||
                  p.cpf!.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return ListView.builder(
      itemCount: listaUsuarios.length,
      itemBuilder: (context, index) {
        final usuario = listaUsuarios[index];
        return ListTile(
          leading: usuario.avatar == ""
              ? const Icon(
                  Icons.account_circle,
                  color: Colors.blue,
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(
                    usuario.avatar!,
                  ),
                ),
          title: Text(usuario.nome!),
          subtitle: Text(usuario.email!),
          onTap: () {
            close(context, usuario.nome!);
          },
        );
      },
    );
  }
}
