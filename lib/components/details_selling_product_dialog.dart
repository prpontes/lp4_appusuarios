import 'package:lp4_appusuarios/components/product/product_description.dart';
import 'package:lp4_appusuarios/components/product/product_info.dart';
import 'package:lp4_appusuarios/components/shopping_cart_dialog.dart';
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
              id: "",
              fornecedor: Fornecedor(id: "", razaoSocial: "")),
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
            actions: [
              Consumer<ShoppingCartProvider>(builder: (context, value, child) {
                var isItemInCart = value.hasProduct(product.id!);
                return IconButton(
                  tooltip: "Adicionar ao carrinho",
                  icon: Icon(isItemInCart
                      ? Icons.shopping_cart_rounded
                      : Icons.add_shopping_cart),
                  // color primaryColor,
                  color: isItemInCart ? Colors.white38 : Colors.white,
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
                          shoppingCartProvider.add(
                            ItemVenda(
                              idProduto: product.id,
                              produto: product,
                              price: product.price,
                              quantity: 1,
                            ),
                          );
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ShoppingCartDialog(),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                );
              }),
            ],
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
                      ProductInfo(
                        product: product,
                        enableStockTap: false,
                        stockLabel: "Qtd disponível: ",
                        rightDetails: [],
                      ),
                      Expanded(child: ProductDescription(product: product)),
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
