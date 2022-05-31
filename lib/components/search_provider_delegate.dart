import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/fornecedores_provider.dart';
import 'package:provider/provider.dart';
import 'details_provider_dialog.dart';

class SearchProviderDelegate extends SearchDelegate<String> {
  SearchProviderDelegate() : super(searchFieldLabel: "Buscar fornecedores");

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
    final fornecedoresProvider = Provider.of<FornecedoresProvider>(context);
    final fornecedores = fornecedoresProvider.fornecedores;
    final listaFornecedores = query.isEmpty
        ? fornecedores
        : fornecedores
            .where(
              (p) =>
                  removeDiacritics(p.razaoSocial!.toLowerCase())
                      .contains(removeDiacritics(query.toLowerCase())) ||
                  p.email!.toLowerCase().contains(query.toLowerCase()) ||
                  p.cnpj!.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return ListView.builder(
      itemCount: listaFornecedores.length,
      itemBuilder: (context, index) {
        final fornecedor = listaFornecedores[index];
        return ListTile(
          leading: fornecedor.imagem == ""
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
                      fornecedor.imagem,
                    ),
                  ),
                ),
          title: Text(fornecedor.razaoSocial!),
          subtitle: Text(fornecedor.email!),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => DetailsProviderDialog(
                  fornecedor: fornecedor,
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
