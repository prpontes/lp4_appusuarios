import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/components/details_product_dialog.dart';
import 'package:lp4_appusuarios/components/mutate_product_dialog.dart';
import 'package:lp4_appusuarios/components/search_product_delegate.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late ProductProvider productProvider;
  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => productProvider.getProducts());
  }

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
                delegate: SearchProductDelegate(
                  products: productProvider.products,
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const MutateProductDialog(),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(Icons.add),
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
                                  Icons.warning_rounded,
                                  color: Colors.blue,
                                  size: 50,
                                )
                              : SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Hero(
                                    tag: "${product.id}",
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        product.image,
                                      ),
                                    ),
                                  ),
                                ),
                          title: Text(product.name),
                          subtitle: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Text(
                              product.description,
                              maxLines: 1,
                            ),
                          ),
                          trailing:
                              Text("R\$ ${product.price.toStringAsFixed(2)}"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DetailsProductDialog(
                                  product: product,
                                ),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Text("nenhum produto");
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
