import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/components/badge.dart';
import 'package:lp4_appusuarios/components/product/product_card.dart';
import 'package:lp4_appusuarios/components/search_product_delegate.dart';
import 'package:lp4_appusuarios/model/item_venda.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';
import 'package:lp4_appusuarios/provider/shopping_cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:lp4_appusuarios/components/details_selling_product_dialog.dart';
import 'package:lp4_appusuarios/components/shopping_cart_dialog.dart';

class BuyPage extends StatefulWidget {
  const BuyPage({Key? key}) : super(key: key);

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  late ProductProvider productProvider;
  late ShoppingCartProvider shoppingCartProvider;
  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    shoppingCartProvider =
        Provider.of<ShoppingCartProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback(
        (_) => productProvider.getProducts(minQuantity: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const ShoppingCartDialog(),
            fullscreenDialog: true,
          ),
        ),
        child: Consumer<ShoppingCartProvider>(
          builder: (context, value, child) {
            var shoppingCartProvider = value;
            var total = shoppingCartProvider.totalIndividualItems;
            if (total == 0) return child!;
            return Badge(
              child: child!,
              value: total.toString(),
              right: 0,
              top: 0,
            );
          },
          child: Icon(
            Icons.shopping_cart,
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Produtos à Venda"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: SearchProductDelegate(
                products: productProvider.products,
              ),
            ),
          ),
        ],
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
        final products = value.products;
        if (value.productsState == ProductsState.complete) {
          if (value.products.isNotEmpty) {
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) => ProductCard(
                product: products[index],
                onTap: (context, product) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DetailsSellingProductDialog(
                        product: product,
                      ),
                      fullscreenDialog: true,
                    ),
                  ).then(
                    (_) {
                      productProvider.getProducts(minQuantity: 1);
                    },
                  );
                },
                topRightBuilder: (product) => Consumer<ShoppingCartProvider>(
                  builder: (context, value, child) {
                    var isItemInCart = value.hasProduct(product.id!);
                    return IconButton(
                      icon: Icon(isItemInCart
                          ? Icons.shopping_cart_rounded
                          : Icons.add_shopping_cart),
                      color: isItemInCart ? Colors.grey[300] : Colors.grey,
                      onPressed: isItemInCart
                          ? () {
                              // show snackbar with product already in cart
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Produto já está no carrinho!"),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            }
                          : () {
                              shoppingCartProvider.add(ItemVenda(
                                idProduto: product.id,
                                produto: product,
                                price: product.price,
                                quantity: 1,
                              ));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ShoppingCartDialog(),
                                  fullscreenDialog: true,
                                ),
                              ).then(
                                (_) {
                                  productProvider.getProducts(minQuantity: 1);
                                },
                              );
                            },
                    );
                  },
                ),
              ),
            );
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: const Text(
                "Nenhum Produto à venda disponível.",
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
