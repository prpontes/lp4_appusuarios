import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final EdgeInsetsGeometry padding;
  final bool showBottomLabel;
  final void Function(BuildContext, Product)? onTap;
  final Widget Function(Product)? topRightBuilder;

  const ProductCard({
    Key? key,
    required this.product,
    this.topRightBuilder,
    this.showBottomLabel = true,
    this.onTap,
    this.padding = const EdgeInsets.only(left: 8, right: 8, top: 5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: () => onTap != null ? onTap!(context, product) : {},
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
          ),
        ),
      ),
    );
  }

  Widget productIcon() {
    if (product.image.isEmpty) {
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
          product.image,
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
