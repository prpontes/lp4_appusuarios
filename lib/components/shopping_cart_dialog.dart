import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/shopping_cart_provider.dart';
import 'package:provider/provider.dart';

class ShoppingCartDialog extends StatefulWidget {
  const ShoppingCartDialog({Key? key}) : super(key: key);

  @override
  State<ShoppingCartDialog> createState() => _ShoppingCartDialogState();
}

class _ShoppingCartDialogState extends State<ShoppingCartDialog> {
  late ShoppingCartProvider _shoppingCartProvider;

  @override
  void initState() {
    super.initState();
    _shoppingCartProvider =
        Provider.of<ShoppingCartProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCartProvider>(
      builder: (context, value, child) {
        var shoppingCartProvider = value;
        var items = shoppingCartProvider.items;
        return Scaffold(
          appBar: AppBar(
            title: Text("Carrinho de Compras"),
          ),
          body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item.id.toString()),
                subtitle: Text(item.price.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        _shoppingCartProvider.decrement(item);
                      },
                    ),
                    Text(item.quantity.toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _shoppingCartProvider.increment(item);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          bottomSheet: Container(
            height: 100,
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total:",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "R\$${shoppingCartProvider.totalPrice}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    _shoppingCartProvider.clear();
                  },
                  child: Text("Limpar"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Fechar"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
