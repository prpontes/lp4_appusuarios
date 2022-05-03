import 'package:lp4_appusuarios/components/delete_user_dialog.dart';
import 'package:lp4_appusuarios/components/mutate_product_dialog.dart';
import 'package:lp4_appusuarios/model/product.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';
import 'package:provider/provider.dart';

class DetailsProductDialog extends StatefulWidget {
  final Product product;
  const DetailsProductDialog({Key? key, required this.product})
      : super(key: key);

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
    return Consumer<ProductProvider>(builder: (context, value, child) {
      Product product = value.products.firstWhere(
        (product) => product.id == widget.product.id,
        orElse: () => Product(
          name: "",
          id: -1,
        ),
      );

      if (product.id == -1) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(product.name),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MutateProductDialog(
                      product: product,
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
            IconButton(
              onPressed: () async {
                // show alert dialog
                final bool confirm = await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => const DeleteDialog(
                    title: "Excluir produto",
                    description: "Tem certeza que deseja excluir o produto?",
                  ),
                );
                if (!confirm) return;
                Navigator.pop(context);
                await productProvider.deleteProduct(product);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  action: SnackBarAction(
                    label: 'Desfazer',
                    onPressed: () async {
                      await productProvider.createProduct(product);
                    },
                  ),
                  content: const Text('Produto deletado com sucesso!'),
                ));
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Fornecedor:",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          const Text(
                            "Um Qualquer",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Preço",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            "R\$ ${product.price.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Hero(
                        tag: "${product.id}",
                        child: product.image == ""
                            ? const Icon(
                                Icons.warning_rounded,
                                color: Colors.blue,
                                size: 150,
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(product.image),
                                radius: 70),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
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
                        child: Text(
                          product.description,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
