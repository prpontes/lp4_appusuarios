import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/produto.dart';

class TelaProdutos extends StatefulWidget {
  const TelaProdutos({Key? key}) : super(key: key);

  @override
  State<TelaProdutos> createState() => _TelaProdutosState();
}

class _TelaProdutosState extends State<TelaProdutos> {
  var products = List.generate(5, (index) => Produto(nome: "Teste $index"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          var product = products[index];
          return Card(
            child: ListTile(
              title: Text(product.nome),
              // leading centered
              leading: const Icon(Icons.shopping_cart),
              subtitle: Text('R\$ ${product.preco}'),
              onTap: () {
                // Navigator.pushNamed(context, '/detalheproduto',
                //     arguments: products[index]);
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.blue,
                    onPressed: () {
                      // Navigator.pushNamed(context, '/editarproduto',
                      //     arguments: products[index]);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      // products.removeAt(index);
                      // setState(() {});
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
