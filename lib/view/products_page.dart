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
    WidgetsBinding.instance!.addPostFrameCallback((_) => productProvider.getProducts());
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
                            builder: (BuildContext context) => DetailsProductDialog(
                              product: product,
                            ),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: product.mainColor, width: 3),
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
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                trailing: Text(
                                  "Estoque: ${product.quantity}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: product.quantity == 0 ? Colors.red : Colors.green,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25, top: 5, bottom: 10, right: 25),
                                child: Text(
                                  "R\$ ${product.price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
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
                        "Nenhum Produto",
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
