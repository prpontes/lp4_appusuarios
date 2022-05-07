import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/auth_provider.dart';
import 'package:lp4_appusuarios/provider/sell_provider.dart';
import 'package:lp4_appusuarios/provider/shopping_cart_provider.dart';
import 'package:provider/provider.dart';

class ShoppingCartDialog extends StatefulWidget {
  const ShoppingCartDialog({Key? key}) : super(key: key);

  @override
  State<ShoppingCartDialog> createState() => _ShoppingCartDialogState();
}

class _ShoppingCartDialogState extends State<ShoppingCartDialog> {
  late ShoppingCartProvider _shoppingCartProvider;

  late SellProvider _sellProvider;

  late AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _shoppingCartProvider =
        Provider.of<ShoppingCartProvider>(context, listen: false);
    _sellProvider = Provider.of<SellProvider>(context, listen: false);
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCartProvider>(
      builder: (context, value, child) {
        var shoppingCartProvider = value;
        var totalItems = shoppingCartProvider.totalItems;
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
                  onPressed: totalItems == 0
                      ? null
                      : () {
                          _shoppingCartProvider.clear();
                        },
                  child: Text("Limpar"),
                ),
                ElevatedButton(
                  onPressed: totalItems == 0
                      ? null
                      : () async {
                          await _sellProvider.buy(items, 1);
                          _shoppingCartProvider.clear();
                          Navigator.of(context).pop();
                        },
                  child: Text("Comprar"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
