import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/components/details_user_dialog.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:provider/provider.dart';

class SearchUserDelegate extends SearchDelegate<String> {
  SearchUserDelegate() : super(searchFieldLabel: "Buscar usuários");

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
    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    final usuarios = usuarioProvider.usuarios;
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
                builder: (BuildContext context) => DetailsUserDialog(
                  usuario: usuario,
                ),
                fullscreenDialog: true,
              ),
            );
          },
        );
      },
    );
  }
}
