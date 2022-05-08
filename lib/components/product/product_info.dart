import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/components/product/product_field.dart';
import 'package:lp4_appusuarios/components/stock_product_dialog.dart';
import 'package:lp4_appusuarios/model/product.dart';

class ProductInfo extends StatelessWidget {
  final Product product;
  const ProductInfo({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  ProductField(
                    field: "Fornecedor: ",
                    value: product.fornecedor.razaoSocial!,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProductField(
                    field: "Estoque: ",
                    value: product.quantity.toString(),
                    valueShadowEnable: true,
                    onValueTap: () => showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => StockDialog(product: product),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProductField(
                    field: "Preço: ",
                    value: "R\$ ${product.price.toStringAsFixed(2)}",
                    valueShadowEnable: true,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Hero(
              tag: "${product.id}",
              child: product.image == ""
                  ? const Icon(
                      Icons.warning_rounded,
                      color: Colors.amber,
                      size: 150,
                    )
                  : Container(
                      width: MediaQuery.of(context).size.height >= MediaQuery.of(context).size.width
                          ? (MediaQuery.of(context).size.width / 2) * 0.8
                          : (MediaQuery.of(context).size.height / 2) * 0.8,
                      height: MediaQuery.of(context).size.height >= MediaQuery.of(context).size.width
                          ? (MediaQuery.of(context).size.width / 2) * 0.8
                          : (MediaQuery.of(context).size.height / 2) * 0.8,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).scaffoldBackgroundColor,
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
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: Image.network(product.image),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: product.mainColor,
                          foregroundImage: NetworkImage(product.image),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
