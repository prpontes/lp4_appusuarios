import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/components/product/product_field.dart';
import 'package:lp4_appusuarios/components/product/stock_product_dialog.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';

class ProductInfo extends StatelessWidget {
  final ProductNotifier productNotifier;

  final bool enableStockTap;
  final List<Widget> rightDetails;

  final bool showProvider;
  final bool showStock;
  final bool showPrice;

  final String providerLabel;
  final String stockLabel;
  final String priceLabel;

  const ProductInfo({
    Key? key,
    required this.productNotifier,
    required this.enableStockTap,
    this.rightDetails = const [],
    this.providerLabel = "Fornecedor: ",
    this.stockLabel = "Estoque: ",
    this.priceLabel = "Preço: ",
    this.showPrice = true,
    this.showProvider = true,
    this.showStock = true,
  }) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: leftDetailsWidgets(context),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: rightDetailsWidgets(context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> leftDetailsWidgets(BuildContext context) {
    List<Widget> widgets = [];
    double spaceBetween = 15;
    if (showProvider) {
      widgets.add(
        ProductField(
          field: providerLabel,
          value: productNotifier.product.fornecedor.razaoSocial!,
        ),
      );
    }
    if (showStock) {
      if (widgets.isNotEmpty) {
        widgets.add(
          SizedBox(
            height: spaceBetween,
          ),
        );
      }
      widgets.add(
        ProductField(
          field: stockLabel,
          value: productNotifier.product.quantity.toString(),
          valueShadowEnable: true,
          onValueTap: () {
            if (enableStockTap) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => StockDialog(productNotifier: productNotifier),
              );
            }
          },
        ),
      );
    }
    if (showPrice) {
      if (widgets.isNotEmpty) {
        widgets.add(
          SizedBox(
            height: spaceBetween,
          ),
        );
      }
      widgets.add(
        ProductField(
          field: priceLabel,
          value: "R\$ ${productNotifier.product.price.toStringAsFixed(2)}",
          valueShadowEnable: true,
        ),
      );
    }
    return widgets;
  }

  List<Widget> rightDetailsWidgets(BuildContext context) {
    final List<Widget> widgets = [];
    widgets.addAll(rightDetails);
    widgets.add(
      Hero(
        tag: "${productNotifier.product.id}",
        child: productNotifier.product.image == ""
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
                          child: Image.network(productNotifier.product.image),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: productNotifier.product.mainColor,
                    foregroundImage: NetworkImage(productNotifier.product.image),
                  ),
                ),
              ),
      ),
    );
    return widgets;
  }
}
