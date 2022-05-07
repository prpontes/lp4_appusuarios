import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/components/badge.dart';
import 'package:lp4_appusuarios/components/search_product_delegate.dart';
import 'package:lp4_appusuarios/model/item_venda.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';
import 'package:lp4_appusuarios/provider/shopping_cart_provider.dart';
import 'package:provider/provider.dart';
import '../components/details_selling_product_dialog.dart';
import '../components/shopping_cart_dialog.dart';

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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const ShoppingCartDialog(),
              fullscreenDialog: true,
            ),
          );
        },
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
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Consumer<ProductProvider>(
          builder: (BuildContext context, value, Widget? child) {
            final products = value.products;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                if (products.isNotEmpty) {
                  final product = products[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DetailsSellingProductDialog(
                              product: product,
                            ),
                            fullscreenDialog: true,
                          ),
                        ).then((_) {
                          productProvider.getProducts(minQuantity: 1);
                        });
                      },
                      child: Card(
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  color: product.mainColor, width: 3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: Hero(
                                  tag: "${product.id}",
                                  child: product.image.isEmpty
                                      ? const Icon(
                                          Icons.warning_rounded,
                                          color: Colors.amber,
                                          size: 50,
                                        )
                                      : SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            foregroundImage: NetworkImage(
                                              product.image,
                                            ),
                                          ),
                                        ),
                                ),
                                title: Text(
                                  product.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Consumer<ShoppingCartProvider>(
                                    builder: (context, value, child) {
                                  var isItemInCart =
                                      value.hasProduct(product.id!);
                                  return IconButton(
                                    icon: Icon(
                                      Icons.shopping_cart,
                                      color: isItemInCart
                                          ? product.mainColor
                                          : Colors.grey,
                                    ),
                                    onPressed: isItemInCart
                                        ? null
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
                                                builder:
                                                    (BuildContext context) =>
                                                        ShoppingCartDialog(),
                                                fullscreenDialog: true,
                                              ),
                                            ).then((_) {
                                              productProvider.getProducts(
                                                  minQuantity: 1);
                                            });
                                          },
                                  );
                                }),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, top: 5, bottom: 10, right: 25),
                                  child: Text(
                                    "R\$ ${product.price.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 30,
                                    ),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, top: 0, bottom: 10, right: 25),
                                  child: Text(
                                    "Clique para ver detalhes",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
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
              },
            );
          },
        ),
      ),
    );
  }
}
