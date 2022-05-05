import 'package:flutter/material.dart';

class ShoppingCartDialog extends StatefulWidget {
  const ShoppingCartDialog({Key? key}) : super(key: key);

  @override
  State<ShoppingCartDialog> createState() => _ShoppingCartDialogState();
}

class _ShoppingCartDialogState extends State<ShoppingCartDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho de Compras"),
      ),
    );
  }
}
