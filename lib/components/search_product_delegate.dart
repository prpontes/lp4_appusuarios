import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/components/details_product_dialog.dart';
import 'package:lp4_appusuarios/model/product.dart';

class SearchProductDelegate extends SearchDelegate<String> {
  List<Product> products;

  SearchProductDelegate({required this.products})
      : super(searchFieldLabel: "Buscar produtos");

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
    final listProducts = query.isEmpty
        ? products
        : products
            .where((p) =>
                removeDiacritics(p.name.toLowerCase())
                    .contains(removeDiacritics(query.toLowerCase())) ||
                p.description.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: listProducts.length,
      itemBuilder: (context, index) {
        final product = listProducts[index];
        return ListTile(
          leading: product.image == ""
              ? const Icon(
                  Icons.warning_rounded,
                  color: Colors.blue,
                  size: 50,
                )
              : SizedBox(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      product.image,
                    ),
                  ),
                ),
          title: Text(product.name),
          subtitle: Text(product.description),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => DetailsProductDialog(
                  product: product,
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
