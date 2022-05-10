import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';
import 'package:provider/provider.dart';

import '../components/home_drawer_customer.dart';
import '../components/product/product_card.dart';
import '../components/search_product_delegate.dart';

class TelaHomeCliente extends StatefulWidget {
  const TelaHomeCliente({Key? key}) : super(key: key);

  @override
  State<TelaHomeCliente> createState() => _TelaHomeClienteState();
}

class _TelaHomeClienteState extends State<TelaHomeCliente> {
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
        drawer: const HomeCustomerDrawer(),
        appBar: AppBar(
          title: const Text("INICIO"),
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
