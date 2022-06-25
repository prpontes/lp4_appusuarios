import 'package:lp4_appusuarios/components/delete_user_dialog.dart';
import 'package:lp4_appusuarios/components/mutate_product_dialog.dart';
import 'package:lp4_appusuarios/components/product/product_description.dart';
import 'package:lp4_appusuarios/components/product/product_info.dart';
import 'package:lp4_appusuarios/model/product.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';
import 'package:provider/provider.dart';

class DetailsProductDialog extends StatefulWidget {
  late final ValueNotifier<Product> _productNotifier;

  DetailsProductDialog({Key? key, required Product product}) : super(key: key) {
    _productNotifier = ValueNotifier(product);
  }

  @override
  State<DetailsProductDialog> createState() => _DetailsProductDialogState();
}

class _DetailsProductDialogState extends State<DetailsProductDialog> {
  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Product>(
        valueListenable: widget._productNotifier,
        builder: (_, product, __) {
          if (product.mainColor == Colors.deepPurple && product.image != "") {
            () async {
              await product.getMainColorFromImage();
              widget._productNotifier.notifyListeners();
            }.call();
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: product.mainColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                product.name,
                style: TextStyle(
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(-0.2, 0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => editProduct(widget._productNotifier),
                ),
                IconButton(
                  onPressed: () => deleteProduct(product, context),
                  icon: const Icon(Icons.delete),
                ),
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
                          enableStockTap: true,
                        ),
                        Expanded(child: ProductDescription(product: product)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<void> editProduct(ValueNotifier<Product> product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => MutateProductDialog(
          product: product,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  Future<void> deleteProduct(Product product, BuildContext context) async {
    final bool confirm = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => const DeleteDialog(
        title: "Excluir produto",
        description: "Tem certeza que deseja excluir o produto?",
      ),
    );
    if (!confirm) return;
    await productProvider.deleteProduct(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () async {
            await productProvider.createProduct(product);
          },
        ),
        content: const Text('Produto deletado com sucesso!'),
      ),
    );
    Navigator.pop(context);
  }
}
