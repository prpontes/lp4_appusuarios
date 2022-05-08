import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/product.dart';

class ProductDescription extends StatelessWidget {
  final Product product;
  const ProductDescription({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              "Descrição",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                product.description.isEmpty ? "Não há descrição" : product.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
