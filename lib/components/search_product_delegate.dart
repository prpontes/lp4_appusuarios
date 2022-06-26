import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/components/details_product_dialog.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';
import 'package:provider/provider.dart';

class SearchProductDelegate extends SearchDelegate<String> {
  SearchProductDelegate() : super(searchFieldLabel: "Buscar produtos");

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
    final productsProvider = Provider.of<ProductProvider>(context, listen: true);
    final products = productsProvider.products;
    final listProducts = query.isEmpty
        ? products
        : products
            .where((p) =>
                removeDiacritics(p.name.toLowerCase()).contains(removeDiacritics(query.toLowerCase())) ||
                p.description.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: listProducts.length,
      itemBuilder: (context, index) {
        final product = listProducts[index];
        return ListTile(
          leading: Hero(
            tag: "${product.id}",
            child: product.image == ""
                ? const Icon(
                    Icons.warning_rounded,
                    color: Colors.amber,
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
          ),
          title: Text(product.name),
          subtitle: Text(
            product.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
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
