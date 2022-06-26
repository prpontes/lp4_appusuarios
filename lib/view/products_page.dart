import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/components/details_product_dialog.dart';
import 'package:lp4_appusuarios/components/mutate_product_dialog.dart';
import 'package:lp4_appusuarios/components/product/product_card.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) => productProvider.getProducts());
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
                delegate: SearchProductDelegate(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const MutateProductDialog(),
            fullscreenDialog: true,
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: body(),
      ),
    );
  }

  Widget body() {
    return Consumer<ProductProvider>(
      builder: (BuildContext context, value, Widget? child) {
        if (value.productsState == ProductsState.complete) {
          final products = value.products;
          if (products.isNotEmpty) {
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) => ProductCard(
                showBottomLabel: true,
                product: products[index],
                topRightBuilder: (product) => Text(
                  "Estoque: ${product.quantity}",
                  style: TextStyle(
                    fontSize: 14,
                    color: product.quantity == 0 ? Colors.red : Colors.green,
                  ),
                ),
                onTap: (context, product) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsProductDialog(
                      product: product,
                    ),
                    fullscreenDialog: true,
                  ),
                ),
              ),
            );
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: const Text(
                "Nenhum Produto",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
