import 'package:lp4_appusuarios/components/shopping_cart_dialog.dart';
import 'package:lp4_appusuarios/components/stock_product_dialog.dart';
import 'package:lp4_appusuarios/model/fornecedor.dart';
import 'package:lp4_appusuarios/model/item_venda.dart';
import 'package:lp4_appusuarios/model/product.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';
import 'package:lp4_appusuarios/provider/shopping_cart_provider.dart';
import 'package:provider/provider.dart';

class DetailsSellingProductDialog extends StatefulWidget {
  final Product product;
  const DetailsSellingProductDialog({Key? key, required this.product})
      : super(key: key);

  @override
  State<DetailsSellingProductDialog> createState() =>
      _DetailsSellingProductDialogState();
}

class _DetailsSellingProductDialogState
    extends State<DetailsSellingProductDialog> {
  late ProductProvider productProvider;
  late ShoppingCartProvider shoppingCartProvider;
  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    shoppingCartProvider =
        Provider.of<ShoppingCartProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        Product product = value.products.firstWhere(
          (product) => product.id == widget.product.id,
          orElse: () => Product(
              name: "",
              id: -1,
              fornecedor: Fornecedor(id: -1, razaoSocial: "")),
        );

        if (product.id == -1) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: product.mainColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(product.name),
            elevation: 0,
          ),
          body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                color: product.mainColor,
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 30),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Vendido por:",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black,
                                            offset: Offset(-0.2, 0.5),
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      product.fornecedor.razaoSocial!,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            offset: Offset(0, 0),
                                            blurRadius: 2,
                                          )
                                        ],
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Qtd disponível:",
                                      style: TextStyle(
                                        shadows: [
                                          Shadow(
                                            color: Colors.black,
                                            offset: Offset(-0.2, 0.5),
                                            blurRadius: 5,
                                          )
                                        ],
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${product.quantity}",
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontFamily: "Cookie",
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            offset: Offset(0, 0),
                                            blurRadius: 5,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Preço",
                                      style: TextStyle(
                                        shadows: [
                                          Shadow(
                                            color: Colors.black,
                                            offset: Offset(-0.2, 0.5),
                                            blurRadius: 5,
                                          ),
                                        ],
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "R\$ ${product.price.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontFamily: "Cookie",
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            offset: Offset(0, 0),
                                            blurRadius: 5,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          shoppingCartProvider.add(ItemVenda(
                                            idProduto: product.id,
                                            produto: product,
                                            price: product.price,
                                            quantity: 1,
                                          ));
                                          Navigator.pop(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        ShoppingCartDialog(),
                                                fullscreenDialog: true,
                                              ));
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "Adicionar ao Carrinho",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Hero(
                                    tag: "${product.id}",
                                    child: product.image == ""
                                        ? const Icon(
                                            Icons.warning_rounded,
                                            color: Colors.amber,
                                            size: 150,
                                          )
                                        : Container(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .height >=
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width
                                                ? (MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        2) *
                                                    0.8
                                                : (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        2) *
                                                    0.8,
                                            height: MediaQuery.of(context)
                                                        .size
                                                        .height >=
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width
                                                ? (MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        2) *
                                                    0.8
                                                : (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        2) *
                                                    0.8,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                  offset: Offset(0, 0),
                                                  blurRadius: 5,
                                                )
                                              ],
                                              color: Colors.transparent,
                                              shape: BoxShape.circle,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      backgroundColor: Theme.of(
                                                              context)
                                                          .scaffoldBackgroundColor,
                                                      child: Image.network(
                                                          product.image),
                                                    );
                                                  },
                                                );
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    product.mainColor,
                                                foregroundImage:
                                                    NetworkImage(product.image),
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                  "Descrição do Produto",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    product.description.isEmpty
                                        ? "Não há descrição"
                                        : product.description,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}