import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/components/search_product_delegate.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchProductDelegate(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (BuildContext context, value, Widget? child) {
                final products = value.products;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    if (products.isNotEmpty == true) {
                      final product = products[index];
                      return Card(
                        child: ListTile(
                          leading: product.image.isEmpty
                              ? const Icon(
                                  Icons.no_backpack,
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
                          trailing: Text(product.price.toString()),
                          onTap: () {},
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
    );
  }
}
