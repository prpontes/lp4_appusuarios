import 'package:lp4_appusuarios/components/delete_user_dialog.dart';
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
    final Product product = widget.product;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Detalhe produto"),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                // await Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => MutateUserDialog(
                //       usuario: user,
                //     ),
                //     fullscreenDialog: true,
                //   ),
                // );
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
        body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Consumer<ProductProvider>(
              builder: (context, value, child) {
                Product product = value.products.firstWhere(
                  (product) => product.id == widget.product.id,
                  orElse: () => Product(
                    name: "",
                    id: -1,
                    idFornecedor: -1,
                  ),
                );

                if (product.id == -1) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    product.image == ""
                        ? const Icon(
                            Icons.warning_rounded,
                            color: Colors.blue,
                            size: 150,
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(product.image),
                            radius: 70),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Nome: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            product.name,
                            style: const TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Descrição: ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Preço: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "R\$ ${product.price.toStringAsFixed(2)}",
                            style: const TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Fornecedor: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "kkkkkkkkkkk Não tem",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
      ),
    );
  }
}
