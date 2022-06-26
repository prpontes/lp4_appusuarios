import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/product.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';

class ProductCard extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final bool showBottomLabel;
  final void Function(BuildContext, Product)? onTap;
  final Widget Function(Product)? topRightBuilder;

  ProductCard({
    Key? key,
    required Product product,
    this.topRightBuilder,
    this.showBottomLabel = true,
    this.onTap,
    this.padding = const EdgeInsets.only(left: 8, right: 8, top: 5),
  }) : super(key: key) {
    _productNotifier = ProductNotifier(product: product);
  }

  late final ProductNotifier _productNotifier;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_productNotifier.product.mainColor == Colors.deepPurple) {
        await _productNotifier.product.getMainColorFromImage();
        _productNotifier.refresh();
      }
    });
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: () => onTap != null ? onTap!(context, _productNotifier.product) : {},
        child: Card(
          elevation: 5,
          child: ValueListenableBuilder<Product>(
            valueListenable: _productNotifier,
            builder: (_, product, __) {
              return Container(
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
                        child: productIcon(),
                      ),
                      title: Text(
                        product.name,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      trailing: topRightBuilder != null ? topRightBuilder!(product) : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 5, bottom: 10, right: 25),
                      child: Text(
                        "R\$ ${product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    bottomLabel(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget productIcon() {
    if (_productNotifier.product.image.isEmpty) {
      return const Icon(
        Icons.warning_rounded,
        color: Colors.amber,
        size: 50,
      );
    }
    return SizedBox(
      width: 50,
      height: 50,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        foregroundImage: NetworkImage(
          _productNotifier.product.image,
        ),
      ),
    );
  }

  Widget bottomLabel() {
    if (showBottomLabel) {
      return Padding(
        padding: const EdgeInsets.only(left: 25, top: 0, bottom: 10, right: 25),
        child: Text(
          "Clique para ver detalhes",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
      );
    }
    return SizedBox();
  }
}
